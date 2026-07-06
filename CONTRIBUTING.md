# Contributing

## Binary files and large assets

This repo tracks ~60 MB of binary blobs (showcase mp4s, large
background pngs, a handful of prebuilt `programs/bin/` binaries).
They were committed before the size policy existed, so they live in
plain git history. New commits should follow these rules:

### Source code, not compiled output

`dot-config/programs/` contains source under `c_src/`, `hs_src/`,
`py_scripts/`, `shell_scripts/`. The matching binaries in `bin/`
(bernoulli, fibonacci, hu, hutao, todo) are reproducible from source
with stock `make` and `runhaskell`. Don't commit a freshly-built
binary — add the source change and let users build locally if they
need the binary.

If a binary is checked in because we can't reproduce it on the host
(e.g. `honkers-launcher` mirrors an external project), add a comment
at the top of the source file pointing at the upstream build, and
keep the binary's sha in `.gitattributes` so we notice if the upstream
shapes it differently.

### Large assets and LFS

Anything over ~1 MB that's a media file (mp4, gif, large png, xcf) is
a candidate for LFS. The patterns in `.gitattributes` declare LFS
filters for these extensions; they take effect if you have
[`git-lfs`](https://git-lfs.github.com) installed on the clone. Without
LFS the patterns are a no-op and the binary stays in git history.

If you add a new large binary and don't have LFS installed, expect
`pre-commit`'s `check-added-large-files --maxkb=512` to block your
commit. Either install LFS, shrink the asset, or (rarely justified)
add an explicit override in `.pre-commit-config.yaml` with a comment
explaining why this one binary gets to break the rule.

### Migration TODO

A future PR should run `git lfs migrate` against the historical
binaries so the working tree pulls LFS pointers instead of full blobs.
That requires a force-push, which is why we haven't done it yet —
do it once, in its own PR, after announcing the plan.

## Shebang policy

Quick version (the long version lives in `.shellcheckrc`):

- bash-syntax scripts → `#!/bin/bash`
- POSIX-clean scripts → `#!/bin/sh`
- zsh-only scripts → `#!/bin/zsh`

Don't use `#!/usr/bin/env bash` unless you can justify the portability
gain in the commit message.

## Commit messages

Conventional commits with a scope. Scan `git log --oneline -50`
before writing yours to match the established scope naming. Examples
from the recent history: `(shell)`, `(ci)`, `(setup)`, `(hermes)`,
`(lint)`, `(stow)`, `(repo)`, `(readme)`, `(gitleaks)`.

User-only authorship. Do not add `Co-authored-by:` trailers even when
an LLM did the work.

## Lint stack

Layered gates — fast at commit, slower at push, full matrix in CI:

- **commit** (`.pre-commit-config.yaml`): gitleaks + byte hygiene
- **push** (`.pre-push-config.yaml`): formatters + per-language linters
- **CI** (`.github/workflows/ci.yml`): same per-language matrix,
  parallel jobs, plus stow dry-run

Run the same checks locally before pushing:

```sh
pre-commit run --all-files             # commit-time gate
pre-commit run --config .pre-push-config.yaml --all-files   # push gate
```
