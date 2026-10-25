# Level 5: Networking, SSH Hardening & Firewalls

## Track Overview
In Levels 1 through 4, you mastered the filesystem, user permissions, process observability, systemd daemons, and scheduled cron automation. In Level 5, you learn the critical engineering skills that protect production servers from external threats on the public internet:

1. **Network Stack & Socket Inspection**: How to inspect IP assignments, routes, and active TCP/UDP listening ports with `ip` and `ss`.
2. **Cryptographic SSH Hardening**: Transitioning from passwords to modern Ed25519 elliptic-curve keypairs and locking down `/etc/ssh/sshd_config`.
3. **Host Firewall with UFW**: Implementing a strict **default deny** security perimeter allowing only HTTP, HTTPS, and SSH.
4. **System Package Hygiene & Security Patches**: Keeping the Linux operating system patched against Common Vulnerabilities and Exposures (CVEs) automatically.

---

## Lesson 5.1 — Network Inspection & Socket Auditing

### 1. Network Interfaces & Routing Table
Modern Linux manages networking through the `iproute2` suite (replacing legacy `ifconfig` and `route`):

- **Interface Inspection (`ip a`)**:
  - `lo`: The loopback virtual interface (`127.0.0.1` / `::1`). Only internal processes on the same host can communicate over loopback.
  - `eth0` / `ens3` / `enp1s0`: The physical or virtual network interface connected to the local subnet or public Internet, assigned an IP (e.g. `192.168.1.15/24`).
- **Routing Table (`ip route`)**:
  - Displays the default gateway (e.g. `default via 192.168.1.1 dev eth0`) through which all external internet packets travel.

```bash
# Display all network interfaces with CIDR subnet masks
ip a

# Inspect default routing gateway
ip route
```

### 2. Socket Auditing (`ss -tulpn`)
The `ss` (Socket Statistics) command inspects the Linux kernel network subsystem:
- `-t`: TCP sockets
- `-u`: UDP sockets
- `-l`: Listening sockets (daemons waiting for incoming connections)
- `-p`: Process ID and program name bound to the socket (requires `sudo`)
- `-n`: Numeric port numbers (prevents slow DNS lookups)

```bash
# Audit all listening TCP/UDP ports and bound processes
sudo ss -tulpn
```

#### Production Port Audit Table
| Local Address:Port | Bound Process | DevOps Context |
|---|---|---|
| `127.0.0.1:5000` | `gunicorn` (Python) | Internal application server (safe: not exposed to internet) |
| `0.0.0.0:80` | `nginx` | Public HTTP reverse proxy (redirects to HTTPS) |
| `0.0.0.0:443` | `nginx` | Public HTTPS TLS termination |
| `0.0.0.0:22` | `sshd` | Secure Shell remote administration port |
| `127.0.0.1:5432` | `postgres` | Database engine (restricted strictly to localhost) |

### 3. Socket Connectivity & Handshake Testing
- `curl -Iv https://www.teachcloud.dev`: Fetches HTTP headers and verifies SSL/TLS certificate validity.
- `nc -zv 127.0.0.1 5000`: Netcat zero-I/O probe testing whether a specific TCP port is open and accepting SYN packets without sending data.

---

## Lesson 5.2 — Cryptographic SSH Hardening

Password-based SSH access on port 22 is targeted by automated brute-force bots within minutes of launching any cloud server. Production servers must mandate **asymmetric cryptographic authentication**.

### 1. Generating Modern Ed25519 Keypairs
Traditional RSA keys require 4096 bits and are slower. **Ed25519** (Edwards-curve Digital Signature Algorithm) offers higher cryptographic strength with a compact 256-bit key and immunity to side-channel timing attacks.

```bash
# Generate Ed25519 keypair on your local computer
ssh-keygen -t ed25519 -C "admin@teachcloud.dev"
```

### 2. Public Key Authorization & Strict File Permissions
The public key (`id_ed25519.pub`) must be appended to the target user's `~/.ssh/authorized_keys` file on the server.

SSH strictly enforces ownership checks — if the file or directory permissions are too loose, the SSH daemon **refuses the login**:
```bash
# Secure the SSH directory and authorized keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R ubuntu:ubuntu ~/.ssh
```

### 3. Hardening `/etc/ssh/sshd_config`
Edit the server SSH daemon configuration (`sudo nano /etc/ssh/sshd_config`):

```ini
# /etc/ssh/sshd_config — CIS Hardened Baseline

# 1. Disable password authentication entirely (kills brute-force attacks)
PasswordAuthentication no

# 2. Prevent direct root login (force privilege escalation via sudo)
PermitRootLogin no

# 3. Enforce cryptographic public key authentication
PubkeyAuthentication yes

# 4. Disable keyboard-interactive passwords
KbdInteractiveAuthentication no

# 5. Limit maximum authentication attempts
MaxAuthTries 3

# 6. Set login grace time (disconnects idle pre-auth connections)
LoginGraceTime 30s
```

Verify syntax and reload the SSH daemon (always keep your current session open while testing a new connection in a separate terminal!):
```bash
sudo sshd -t && sudo systemctl reload ssh
```

---

## Lesson 5.3 — Host Firewall with UFW (Uncomplicated Firewall)

**UFW** is an intuitive frontend for Netfilter / `iptables` / `nftables` that manages incoming and outgoing network packets.

### The Golden Security Rule: **Default Deny**
A hardened host rejects all unsolicited incoming traffic by default, only opening explicitly audited ports.

```bash
# 1. Set default policies: Block all incoming, allow all outbound
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. CRITICAL: Allow SSH before enabling UFW to prevent lockout!
sudo ufw allow 22/tcp comment 'SSH Administration'

# 3. Allow web traffic for Nginx reverse proxy
sudo ufw allow 80/tcp comment 'HTTP Web Redirect'
sudo ufw allow 443/tcp comment 'HTTPS Encrypted Web'

# 4. Activate the firewall
sudo ufw enable

# 5. Inspect active rules with packet counters
sudo ufw status verbose
```

### Example `sudo ufw status verbose` Output:
```text
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                   # SSH Administration
80/tcp                     ALLOW IN    Anywhere                   # HTTP Web Redirect
443/tcp                    ALLOW IN    Anywhere                   # HTTPS Encrypted Web
22/tcp (v6)                ALLOW IN    Anywhere (v6)              # SSH Administration
80/tcp (v6)                ALLOW IN    Anywhere (v6)              # HTTP Web Redirect
443/tcp (v6)               ALLOW IN    Anywhere (v6)              # HTTPS Encrypted Web
```

---

## Lesson 5.4 — Package Management & Security Updates

Security vulnerabilities (CVEs) in OpenSSL, Nginx, Linux kernel, or Python runtimes are discovered continuously. Maintaining automated patching safeguards production servers from zero-day exploits.

### 1. Manual Package Operations with APT
- `sudo apt update`: Downloads latest repository index lists from Canonical mirrors.
- `sudo apt upgrade -y`: Installs updated package binaries without removing existing packages.
- `sudo apt autoremove -y`: Purges orphaned dependencies and deprecated kernel images.
- `sudo apt clean`: Flushes cached `.deb` installer archives from `/var/cache/apt/archives/` to reclaim disk space.

### 2. Automated Unattended Security Patching
Ubuntu includes `unattended-upgrades`, which queries upstream package repositories daily and applies critical security patches automatically in the background without human intervention.

Verify automated upgrades configuration in `/etc/apt/apt.conf.d/20auto-upgrades`:
```text
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
```
Reboot management in `/etc/apt/apt.conf.d/50unattended-upgrades`:
```text
Unattended-Upgrade::Automatic-Reboot "true";
Unattended-Upgrade::Automatic-Reboot-Time "03:00";
```
