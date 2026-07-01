#!/usr/bin/env node

/**
 * OpenRouter Image Generation MCP Server
 *
 * Lets the agent generate images (UI mockups, design explorations, etc.)
 * via OpenRouter's chat completions API with image output modalities.
 */

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

// ── Config ───────────────────────────────────────────────

const OPENROUTER_API_BASE = "https://openrouter.ai/api/v1";

function getApiKey(): string {
  const key = process.env.OPENROUTER_API_KEY ?? process.env.OPENROUTER_TOKEN;
  if (!key) {
    console.error("ERROR: OPENROUTER_API_KEY or OPENROUTER_TOKEN environment variable is required");
    process.exit(1);
  }
  return key;
}

// ── Zod Schemas ──────────────────────────────────────────

const ImageGenerationInputSchema = z.object({
  prompt: z
    .string()
    .min(1, "Prompt is required")
    .max(4000, "Prompt must not exceed 4000 characters")
    .describe(
      "Detailed description of the image to generate. For UI mockups, describe layout, colors, components, and style.",
    ),

  model: z
    .string()
    .default("google/gemini-2.5-pro-preview-03-25")
    .describe(
      "OpenRouter model ID that supports image output. Default: google/gemini-2.5-pro-preview-03-25. " +
        "Others: google/gemini-2.5-flash-image-preview (free), openai/gpt-5-image, black-forest/flux-dev, etc.",
    ),

  aspect_ratio: z
    .string()
    .default("1:1")
    .describe("Aspect ratio for the generated image (e.g., '1:1', '16:9', '4:3', '3:2')"),

  size: z
    .string()
    .optional()
    .describe("Image size hint (e.g., '1024x1024', '4K'). Overrides aspect_ratio if set."),

  quality: z
    .enum(["standard", "high"])
    .default("standard")
    .describe("Image quality. 'high' for finer detail, 'standard' for faster generation."),

  output_format: z.enum(["png", "webp", "jpeg"]).default("webp").describe("Output image format."),
});

type ImageGenerationInput = z.infer<typeof ImageGenerationInputSchema>;

// ── API Client ───────────────────────────────────────────

interface OpenRouterImageResponse {
  choices?: Array<{
    message: {
      content?: string | null;
      images?: Array<{
        image_url?: { url: string };
        imageUrl?: { url: string };
      }>;
    };
  }>;
  error?: { message: string; code?: string };
}

async function generateImage(
  params: ImageGenerationInput,
): Promise<{ imageUrl: string; altText: string }> {
  const apiKey = getApiKey();

  const payload: Record<string, unknown> = {
    model: params.model,
    messages: [
      {
        role: "user",
        content: params.prompt,
      },
    ],
    modalities: ["image"],
    image_config: {
      aspect_ratio: params.aspect_ratio,
      quality: params.quality,
      output_format: params.output_format,
    },
  };

  if (params.size) {
    (payload.image_config as Record<string, unknown>).size = params.size;
  }

  const response = await fetch(`${OPENROUTER_API_BASE}/chat/completions`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${apiKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify(payload),
  });

  const data = (await response.json()) as OpenRouterImageResponse;

  if (!response.ok) {
    const errMsg = data.error?.message ?? `HTTP ${response.status}`;
    throw new Error(`OpenRouter API error: ${errMsg}`);
  }

  const choice = data.choices?.[0];
  if (!choice) {
    throw new Error("No response from model — unexpected response structure");
  }

  // Extract image from response — images field or content
  const images = choice.message.images ?? [];
  if (images.length > 0) {
    const url = images[0].image_url?.url ?? images[0].imageUrl?.url ?? "";
    if (url) {
      return { imageUrl: url, altText: choice.message.content ?? params.prompt };
    }
  }

  // Fallback: check if content contains a markdown image or URL
  const content = choice.message.content ?? "";
  const mdMatch = content.match(/!\[.*?\]\((.*?)\)/);
  if (mdMatch) {
    return { imageUrl: mdMatch[1], altText: params.prompt };
  }

  const urlMatch = content.match(/https?:\/\/[^\s)]+/);
  if (urlMatch) {
    return { imageUrl: urlMatch[0], altText: params.prompt };
  }

  // If we got text back but no image, return it as context
  if (content) {
    throw new Error(
      `Model returned text instead of an image. Try a different model (e.g., google/gemini-2.5-flash-image-preview). Response: ${content.slice(0, 300)}`,
    );
  }

  throw new Error("No image generated — unexpected response structure");
}

// ── MCP Server ───────────────────────────────────────────

const server = new McpServer({
  name: "openrouter-image-mcp-server",
  version: "1.0.0",
});

server.registerTool(
  "openrouter_generate_image",
  {
    title: "Generate Image via OpenRouter",
    description: `Generates an image from a text prompt using OpenRouter's image-capable models.

Use this tool when you need to:
- Generate UI mockups and design explorations
- Create visual references for frontend components
- Produce template UIs, wireframes, or style tiles
- Generate any image from a text description

The tool accepts a detailed prompt and optional parameters (model, aspect_ratio, size, quality, output_format) and returns a data URL or public image URL.

Args:
  - prompt (string, required): Detailed description of the image. For UI mockups describe layout, colors, components, and style.
  - model (string, optional): OpenRouter model ID (default: google/gemini-2.5-pro-preview-03-25)
  - aspect_ratio (string, optional): Aspect ratio (default: '1:1', options: '1:1', '16:9', '4:3', '3:2')
  - size (string, optional): Exact size like '1024x1024', overrides aspect_ratio if set
  - quality ('standard' | 'high', optional): Image quality (default: 'standard')
  - output_format ('png' | 'webp' | 'jpeg', optional): Output format (default: 'webp')

Returns:
  {
    "imageUrl": string,  // Data URL or public URL of the generated image
    "altText": string    // Descriptive alt text for the image
  }

Examples:
  - "Generate a dark-mode dashboard UI with a sidebar, header, and card grid"
  - "Create a landing page hero section with a gradient background and centered CTA button"
  - "Design a mobile settings screen with toggles, sliders, and list items"

Error Handling:
  - Returns clear error if the model doesn't support image output
  - Suggests alternative models if generation fails`,
    inputSchema: ImageGenerationInputSchema,
    annotations: {
      readOnlyHint: true,
      destructiveHint: false,
      idempotentHint: false,
      openWorldHint: true,
    },
  },
  async (params: ImageGenerationInput) => {
    try {
      const result = await generateImage(params);

      const text = [
        `## Generated Image`,
        ``,
        `**Alt text**: ${result.altText}`,
        ``,
        `![${result.altText}](${result.imageUrl})`,
        ``,
        `---`,
        `*Model: ${params.model} | Format: ${params.output_format} | Aspect ratio: ${params.aspect_ratio}*`,
      ].join("\n");

      return {
        content: [{ type: "text", text }],
        structuredContent: {
          imageUrl: result.imageUrl,
          altText: result.altText,
          model: params.model,
          output_format: params.output_format,
          aspect_ratio: params.aspect_ratio,
        },
      };
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      return {
        content: [
          {
            type: "text",
            text: `Error: ${message}\n\nTip: Try specifying a different model that supports image output, e.g. \`google/gemini-2.5-flash-image-preview\` or \`openai/gpt-5-image\`.`,
          },
        ],
      };
    }
  },
);

// ── Main ─────────────────────────────────────────────────

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("openrouter-image-mcp-server running via stdio");
}

main().catch((err) => {
  console.error("Fatal error:", err);
  process.exit(1);
});
