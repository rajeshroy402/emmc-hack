#!/usr/bin/env bash
set -e

# ─── Author Info ───────────────────────────────────────────────
AUTHOR_NAME="Rajesh Roy"
AUTHOR_EMAIL="rajeshroy402@gmail.com"

echo "Author: $AUTHOR_NAME <$AUTHOR_EMAIL>"
echo

# ─── Step 1: Format the NVMe partition as ext4 ────────────────
echo "Formatting /dev/nvme0n1p1 as ext4..."
mkfs.ext4 /dev/nvme0n1p1

# ─── Step 2: Create the mount point ────────────────────────────
echo "Creating mount point at /mnt/nvme..."
mkdir -p /mnt/nvme

# ─── Step 3: Mount it now ──────────────────────────────────────
echo "Mounting /dev/nvme0n1p1 to /mnt/nvme..."
mount /dev/nvme0n1p1 /mnt/nvme

# ─── Step 4: Give ownership to nvidia user ─────────────────────
echo "Setting ownership of /mnt/nvme to nvidia:nvidia..."
chown nvidia:nvidia /mnt/nvme

# ─── Step 5: Auto-mount on boot ─────────────────────────────────
echo "Adding entry to /etc/fstab..."
printf '/dev/nvme0n1p1\t/mnt/nvme\text4\tdefaults,nofail\t0\t2\n' >> /etc/fstab

echo "Reloading mounts..."
mount -a

echo
echo "✅ NVMe setup complete! Mounted at /mnt/nvme"
