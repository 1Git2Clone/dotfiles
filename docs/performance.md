# System Performance Tuning

Hardware: AMD Ryzen 5 3600X · RX 5600 XT · NVMe + 1.8TB NTFS HDD · 16GB RAM

## What's configured

### Kernel

- **linux-cachyos** (7.1.x) — EEVDF + BORE + LTO + AutoFDO + Propeller
- Zstdram compression via `zram-generator`

### Virtual Memory (`system/sysctl.d/99-custom.conf`)

| Setting | Value | Why |
|---------|-------|-----|
| `vm.swappiness` | 15 | Keep processes in RAM, only swap when necessary with ZRAM |
| `vm.page-cluster` | 0 | No read-ahead for compressed swap (pointless for ZRAM) |
| `vm.dirty_ratio` | 10 | Write dirty pages sooner to avoid write storms |
| `vm.dirty_background_ratio` | 3 | Start background writeback early |
| `vm.dirty_writeback_centisecs` | 500 | Flush every 5s |
| `vm.dirty_expire_centisecs` | 3000 | Expire dirty pages after 30s |

### Network (`system/sysctl.d/99-custom.conf`)

| Setting | Value | Why |
|---------|-------|-----|
| `net.core.somaxconn` | 65535 | Higher connection backlog |
| `net.ipv4.tcp_fastopen` | 3 | Client + server TCP fast open |
| `net.ipv4.tcp_no_metrics_save` | 1 | Don't cache stale TCP metrics |

### Filesystem

| Setting | Value | Why |
|---------|-------|-----|
| `fs.file-max` | 2097152 | Higher fd limit for Electron/browsers |
| `fs.inotify.max_user_watches` | 524288 | Prevents "too many open files" in large projects |
| `fs.inotify.max_user_instances` | 1024 | More inotify instances |

### I/O Scheduler (`system/udev/rules.d/60-io-scheduler.rules`)

| Device | Scheduler | Why |
|--------|-----------|-----|
| NVMe / SSD | `none` | Hardware handles queuing, lowest latency |
| HDD (rotational) | `bfq` | Fair queuing for spinning disks |

### Process Scheduling

Two options (pick one, they conflict):

1. **scx_lavd** (from `scx-scheds`) — CachyOS desktop-optimized sched-ext scheduler

   Requires `scx_loader` (system D-Bus service) and `scx-scheds` package. Managed via `scxctl`.
   The `scx-lavd.service` system unit is installed by `sudo bash system/install.sh`.

   ```bash
   paru -S scx-scheds
   sudo bash system/install.sh      # installs + enables the service
   scxctl start --sched lavd        # manual start
   scxctl stop                      # manual stop
   scxctl get                       # check running scheduler
   ```

2. **ananicy-cpp** — Auto-nices background processes
   ```bash
   sudo systemctl enable --now ananicy-cpp
   ```

### Hardware Acceleration

- GPU: `vulkan-radeon` + `lib32-vulkan-radeon` (RX 5600 XT / RDNA1)
- Mesa: stable (not -git)

## Installation

System-level configs need sudo:

```bash
sudo bash system/install.sh
```

This copies sysctl and udev rules to `/etc/` and reloads them immediately.

## Manual tuning

```bash
# Live-change swappiness (resets on reboot)
sudo sysctl vm.swappiness=15

# Check current I/O scheduler
cat /sys/block/nvme0n1/queue/scheduler

# Check current CPU governor
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
```
