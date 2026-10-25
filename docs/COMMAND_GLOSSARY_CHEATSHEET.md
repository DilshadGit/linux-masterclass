# 📖 Linux Command Glossary & Acronym Decoder (Master Reference)

A beginner-friendly and comprehensive reference explaining standard Linux commands, the historical origin of their abbreviations, what they actually do, and real-world DevOps usage.

---

## 🗺️ Master Command Reference Table

| Command | What the Letters Stand For | Category | Plain-English Job (What it does) | Everyday Production Example |
| :--- | :--- | :--- | :--- | :--- |
| **`pwd`** | **P**rint **W**orking **D**irectory | Navigation | Prints the full absolute path of your current location. | `pwd` |
| **`ls`** | **L**i**s**t | Navigation | Lists all files, folders, permissions, and timestamps. | `ls -la /var/log` |
| **`cd`** | **C**hange **D**irectory | Navigation | Moves your shell session into another folder. | `cd /opt/teach-cloud` |
| **`mkdir`** | **M**a**k**e **Dir**ectory | Filesystem | Creates new directories, including nested parents with `-p`. | `mkdir -p releases/v1.0` |
| **`cp`** | **C**o**p**y | Filesystem | Duplicates files or entire directory trees (`-r`). | `cp -r conf/ conf.bak/` |
| **`mv`** | **M**o**v**e | Filesystem | Moves or renames files/folders atomically without copying. | `mv app.py server.py` |
| **`rm`** | **R**e**m**ove | Filesystem | Permanently deletes files or directory hierarchies (`-rf`). | `rm -rf /tmp/cache` |
| **`touch`** | **Touch** (timestamp) | Filesystem | Creates a blank 0-byte file or refreshes file timestamps. | `touch deploy.lock` |
| **`cat`** | Con**cat**enate | Text / Inspect | Streams entire text file contents directly onto the console. | `cat /etc/hosts` |
| **`less`** | **Less** ("less is more") | Text / Inspect | Safely pages through large (10GB+) files without crashing RAM. | `less production.log` |
| **`head`** | **Head** (top) | Text / Inspect | Reads only the first $N$ lines of a file (e.g. CSV header). | `head -n 20 users.csv` |
| **`tail`** | **Tail** (bottom) | Text / Inspect | Reads the last $N$ lines or follows streaming logs in real time. | `tail -f /var/log/syslog` |
| **`grep`** | **G**lobal **R**egular **E**xpression **P**rint | Search | Recursively searches files for text patterns or status codes. | `grep -rn "500" /var/log/nginx/` |
| **`find`** | **Find** (files) | Search | Recursively searches directory trees by name, size, or time. | `find /var/log -name "*.log"` |
| **`id`** | **Id**entity | Security | Displays current user UID, primary GID, and security groups. | `id` |
| **`whoami`** | **Who am I** | Security | Prints the username currently executing the shell. | `whoami` |
| **`chmod`** | **Ch**ange **Mod**e | Permissions | Sets read/write/execute permissions (octal `755`, `600`, `644`). | `chmod 600 .env` |
| **`chown`** | **Ch**ange **Own**er | Ownership | Transfers file user and group ownership to service accounts. | `chown -R appuser:appgroup /app` |
| **`chgrp`** | **Ch**ange **Gr**ou**p** | Ownership | Changes the assigned group of a file or directory. | `chgrp devops /opt/shared` |
| **`ps`** | **P**rocess **S**tatus | Processes | Displays active snapshot of running processes and PIDs. | `ps aux \| grep gunicorn` |
| **`pstree`** | **P**rocess **S**tatus **Tree** | Processes | Visualizes parent-child process hierarchy trees from PID 1. | `pstree -p` |
| **`kill`** | Terminate process | Processes | Dispatches signals (`-15` SIGTERM graceful, `-9` SIGKILL force). | `kill -15 1421` |
| **`pkill`** | **P**attern **Kill** | Processes | Terminates processes matching command line regex patterns. | `pkill -f gunicorn` |
| **`jobs`** | Background **Jobs** | Job Control | Lists active background jobs managed by current terminal session. | `jobs -l` |
| **`nohup`** | **No** **H**ang**up** | Job Control | Protects background scripts from closing on SSH disconnect. | `nohup python3 app.py &` |
| **`free`** | **Free** memory | Observability | Displays system RAM, swap, and buffer/cache availability. | `free -h` |
| **`df`** | **D**isk **F**ree | Observability | Shows available storage partitions and percentage utilization. | `df -h /` |
| **`du`** | **D**isk **U**sage | Observability | Profiles byte sizes of specific directories and files. | `du -sh /var/log/*` |
| **`uptime`** | System **Uptime** | Observability | Reports time running, active users, and 1/5/15-min CPU load. | `uptime` |
| **`systemctl`** | **System** **C**on**t**ro**l** | Systemd | Controls service daemons (start, stop, restart, enable, status). | `systemctl status teachcloud` |
| **`journalctl`** | **Journal** **C**on**t**ro**l** | Observability | Streams and audits structured binary logs from systemd-journald. | `journalctl -u teachcloud -f` |
| **`crontab`** | **Chron**os **Tab**le | Automation | Configures automated scheduled periodic execution tasks. | `crontab -l` |
| **`ip`** | **I**nternet **P**rotocol | Networking | Inspects and configures network links, IP CIDRs, and routing. | `ip a` |
| **`ss`** | **S**ocket **S**tatistics | Networking | Dumps socket tables and audits listening TCP/UDP ports and PIDs. | `ss -tulpn` |
| **`curl`** | **C**lient **URL** | Networking | Transfers data and tests HTTP/HTTPS/TLS handshakes and headers. | `curl -Iv https://teachcloud.dev` |
| **`nc`** | **N**et**c**at | Networking | TCP/IP Swiss Army knife for socket connections and port scans. | `nc -zv 127.0.0.1 5000` |
| **`ssh-keygen`** | **S**ecure **Sh**ell **Key** **Gen**erator | Security | Generates cryptographic authentication keypairs (Ed25519). | `ssh-keygen -t ed25519` |
| **`ufw`** | **U**ncomplicated **F**ire**w**all | Security | Host packet filtering and ingress/egress port access policies. | `ufw status verbose` |
| **`apt`** | **A**dvanced **P**ackage **T**ool | Package Mgmt | Debian/Ubuntu package indexing, upgrades, and vulnerability patches. | `apt update` |

