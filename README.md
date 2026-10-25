# 🐧 Linux & Terminal Administration Masterclass

[![Author: DilshadGit](https://img.shields.io/badge/Author-DilshadGit-10b981.svg)](https://github.com/DilshadGit)
[![License: MIT](https://img.shields.io/badge/License-MIT-38bdf8.svg)](LICENSE)
[![Platform: Ubuntu/Debian/RHEL](https://img.shields.io/badge/Platform-Linux%20%7C%20Bash-f59e0b.svg)]()

From core shell commands to production server hardening, systemd automation, SSH key authentication, and network observability.

---

## 🗺️ Curriculum Structure

* [**Level 0: OS Foundations & Installation**](docs/LEVEL_0_OS_FOUNDATIONS_AND_INSTALLATION.md) — Kernel vs OS, Monolithic architecture, WSL2 & native installation.
* [**Level 1: Terminal Foundations & Navigation**](docs/LEVEL_1_TERMINAL_FOUNDATIONS.md) — FHS directory hierarchy, pipes, redirections, and text processing (`grep`, `awk`, `sed`).
* [**Level 2: Permissions & Security Hardening**](docs/LEVEL_2_PERMISSIONS_AND_SECURITY.md) — Octal/symbolic permissions, `chmod`, `chown`, SUID, SGID, sticky bit (`1777`), and `umask`.
* [**Level 3: Processes & System Observability**](docs/LEVEL_3_PROCESSES_AND_OBSERVABILITY.md) — Signals (`SIGTERM` vs `SIGKILL`), `ps`, `top`, `/proc` filesystem, and job control (`nohup`).
* [**Level 4: Daemons & Systemd Automation**](docs/LEVEL_4_SYSTEMD_AND_AUTOMATION.md) — Unit files, `systemctl`, `journalctl`, daemon-reload, and crontab automation.
* [**Level 5: Networking & Enterprise Security**](docs/LEVEL_5_NETWORKING_AND_SECURITY.md) — `ip`, `ss -tulpn`, SSH key management, OpenSSH hardening, and UFW firewall.
* [**Command Glossary & Cheatsheet**](docs/COMMAND_GLOSSARY_CHEATSHEET.md) — Quick command reference.
* [**Interactive Masterclass Quiz (24 Questions)**](QUIZ.md) — Full 24-question multiple choice test with explanations.

---

## 🚀 Quick Start Diagnostic Script
```bash
chmod +x scripts/system_health_check.sh
./scripts/system_health_check.sh
```
