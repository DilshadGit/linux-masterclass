# Linux Systems Engineering & Administration - Masterclass Examination (24 Questions)

> **Instructions**: Test your comprehensive knowledge across all 6 core levels and industrial practices. Each question contains four choices with exactly one correct answer. An in-depth Answer Key with technical explanations is provided at the bottom.

## Questions

### Question 1
**Which Linux directory contains host-specific system-wide configuration files?**

- **A)** /bin
- **B)** /etc
- **C)** /var
- **D)** /usr

### Question 2
**Which command is used to modify file access permissions in numeric (octal) or symbolic mode?**

- **A)** chown
- **B)** chmod
- **C)** chgrp
- **D)** umask

### Question 3
**What does an octal permission value of 755 signify for a directory in Linux?**

- **A)** Owner full access (rwx), group and others read/execute (r-x)
- **B)** Owner full access, group and others read/write (rw-)
- **C)** Everyone on the system has unrestricted full access (rwx)
- **D)** Owner read/write, group read only, others denied

### Question 4
**Which signal is sent by default when running 'kill <PID>' without arguments?**

- **A)** SIGKILL (9)
- **B)** SIGTERM (15)
- **C)** SIGHUP (1)
- **D)** SIGSTOP (19)

### Question 5
**Which signal cannot be caught, blocked, or ignored by any user process in Linux?**

- **A)** SIGTERM (15)
- **B)** SIGINT (2)
- **C)** SIGKILL (9)
- **D)** SIGUSR1 (10)

### Question 6
**In systemd, which command reloads unit files from disk after you modify a .service file?**

- **A)** systemctl restart
- **B)** systemctl reload-daemon
- **C)** systemctl daemon-reload
- **D)** systemctl refresh

### Question 7
**Which Linux command displays active socket connections, listening ports, and protocol statistics?**

- **A)** ps aux
- **B)** ss -tuln
- **C)** top
- **D)** df -h

### Question 8
**Which configuration file defines static filesystem mount tables loaded during boot?**

- **A)** /etc/mtab
- **B)** /etc/fstab
- **C)** /etc/filesystems
- **D)** /proc/mounts

### Question 9
**What is the primary architectural difference between a hard link and a symbolic (soft) link?**

- **A)** Hard links can cross distinct filesystems; symlinks cannot
- **B)** Hard links share the identical inode number; symlinks point to a file path
- **C)** Hard links only point to directories; symlinks point to regular files
- **D)** Symlinks are automatically purged whenever the source file is modified

### Question 10
**Which command is used to inspect kernel ring buffer diagnostic messages and boot telemetry?**

- **A)** journalctl -f
- **B)** dmesg
- **C)** syslog
- **D)** strace

### Question 11
**Which utility is used to intercept and record system calls made and signals received by a running process?**

- **A)** tcpdump
- **B)** lsof
- **C)** strace
- **D)** vmstat

### Question 12
**What security guarantee does the 'Sticky Bit' (chmod +t or 1777) provide on shared directories like /tmp?**

- **A)** Prevents non-root users from reading files inside the directory
- **B)** Only the file owner, directory owner, or root can delete or rename files within it
- **C)** Forces all created files to automatically become world-executable
- **D)** Directs the kernel to lock the directory into physical RAM

### Question 13
**What does running the Linux command 'lsof -i :8080' accomplish?**

- **A)** Terminates all processes actively bound to port 8080
- **B)** Lists open files and processes listening on or connected to network port 8080
- **C)** Permits inbound firewall traffic through port 8080
- **D)** Performs a benchmark throughput test against port 8080

### Question 14
**Which virtual pseudo-filesystem exposes live kernel metrics and process information (e.g., cpuinfo, meminfo)?**

- **A)** /sys
- **B)** /proc
- **C)** /dev
- **D)** /var/log

### Question 15
**What is the role of the 'umask' setting in Linux environments?**

- **A)** Encrypts stored shadow user passwords
- **B)** Defines default permission bits masked (subtracted) from newly created files and directories
- **C)** Hides private IP addresses from network interfaces
- **D)** Rotates and compresses system log archives

### Question 16
**Which systemd unit type is designed to schedule recurring or delayed jobs as a modern replacement for cron?**

- **A)** .target
- **B)** .timer
- **C)** .cron
- **D)** .schedule

### Question 17
**Which command checks disk space utilization across all mounted storage partitions in human-readable format?**

- **A)** du -sh *
- **B)** df -h
- **C)** free -m
- **D)** lsblk

### Question 18
**In bash shell scripting, what does the construct '2>&1' perform?**

- **A)** Redirects standard input (0) to standard error (2)
- **B)** Redirects standard error (file descriptor 2) to standard output (file descriptor 1)
- **C)** Executes the process in background mode
- **D)** Pipes stdout simultaneously to two terminals

### Question 19
**Which Linux command inspects and configures user password expiration dates and aging policies?**

- **A)** chage
- **B)** passwd -d
- **C)** usermod -L
- **D)** id

### Question 20
**Which performance tool provides real-time I/O utilization statistics for block storage devices and active processes?**

- **A)** iotop / iostat
- **B)** netstat
- **C)** ip link
- **D)** uptime

### Question 21
**What occurs when a process finishes execution but its parent has not yet invoked wait() to read its termination status?**

- **A)** It is immediately adopted by systemd as an Orphan
- **B)** It remains in the process table as a Zombie process (defunct)
- **C)** The operating system kernel triggers a system panic
- **D)** Its memory allocations are permanently corrupted

### Question 22
**Which Linux command-line tool captures and analyzes network packet headers on a live interface?**

- **A)** curl
- **B)** tcpdump
- **C)** dig
- **D)** traceroute

### Question 23
**Which configuration tool or file adjusts kernel runtime tuning parameters (like ip_forward and swappiness)?**

- **A)** sysctl / /etc/sysctl.conf
- **B)** export / ~/.bashrc
- **C)** grub / /etc/default/grub
- **D)** crontab / /etc/crontab

### Question 24
**Which command prints the full list of shared dynamic libraries required by an executable binary?**

- **A)** ldd
- **B)** ldconfig
- **C)** readelf
- **D)** nm

## Comprehensive Answer Key & Technical Explanations

### Q1: **Option B** — `/etc`

- **Deep Technical Rationale**: The **/etc** directory contains host-specific system-wide configuration files (e.g., fstab, hosts, and daemon configs).

### Q2: **Option B** — `chmod`

- **Deep Technical Rationale**: **chmod** (change mode) changes file mode bits controlling read, write, and execute permissions.

### Q3: **Option A** — `Owner full access (rwx), group and others read/execute (r-x)`

- **Deep Technical Rationale**: **755** translates to `rwxr-xr-x`: owner has 7 (r+w+x), group has 5 (r+x), others have 5 (r+x).

### Q4: **Option B** — `SIGTERM (15)`

- **Deep Technical Rationale**: The **kill** command sends **SIGTERM (signal 15)** by default, requesting a graceful termination.

### Q5: **Option C** — `SIGKILL (9)`

- **Deep Technical Rationale**: **SIGKILL (signal 9)** and **SIGSTOP (signal 19)** cannot be caught, blocked, or handled by any process.

### Q6: **Option C** — `systemctl daemon-reload`

- **Deep Technical Rationale**: **systemctl daemon-reload** notifies systemd to scan for new or altered unit files.

### Q7: **Option B** — `ss -tuln`

- **Deep Technical Rationale**: **ss -tuln** displays TCP (-t), UDP (-u), listening sockets (-l), without resolving names (-n).

### Q8: **Option B** — `/etc/fstab`

- **Deep Technical Rationale**: **/etc/fstab** (filesystem table) specifies storage partitions and mount points loaded during system initialization.

### Q9: **Option B** — `Hard links share the identical inode number; symlinks point to a file path`

- **Deep Technical Rationale**: A **hard link** directly shares the source file's inode number; a **symbolic link** is a special file pointing to a target pathname.

### Q10: **Option B** — `dmesg`

- **Deep Technical Rationale**: **dmesg** (display message) prints and controls the kernel ring buffer, reporting hardware initialization and driver logs.

### Q11: **Option C** — `strace`

- **Deep Technical Rationale**: **strace** is a diagnostic and debugging tool for monitoring interactions between user processes and the Linux kernel.

### Q12: **Option B** — `Only the file owner, directory owner, or root can delete or rename files within it`

- **Deep Technical Rationale**: The **sticky bit** prevents unprivileged users from deleting or renaming other users' files in shared world-writable directories.

### Q13: **Option B** — `Lists open files and processes listening on or connected to network port 8080`

- **Deep Technical Rationale**: **lsof -i :8080** (list open files) inspects active network sockets and outputs process IDs bound to port 8080.

### Q14: **Option B** — `/proc`

- **Deep Technical Rationale**: The **/proc** virtual filesystem acts as an interface to internal kernel data structures and running process state.

### Q15: **Option B** — `Defines default permission bits masked (subtracted) from newly created files and directories`

- **Deep Technical Rationale**: **umask** determines the default base permission mask stripped from newly instantiated files (base 666) and directories (base 777).

### Q16: **Option B** — `.timer`

- **Deep Technical Rationale**: systemd **.timer** units trigger corresponding `.service` units based on calendar events or monotonic intervals.

### Q17: **Option B** — `df -h`

- **Deep Technical Rationale**: **df -h** (disk filesystem human-readable) lists filesystem capacities, used percentages, and mount destinations.

### Q18: **Option B** — `Redirects standard error (file descriptor 2) to standard output (file descriptor 1)`

- **Deep Technical Rationale**: **2>&1** duplicates file descriptor 2 (stderr) to file descriptor 1 (stdout), combining error logs with standard output.

### Q19: **Option A** — `chage`

- **Deep Technical Rationale**: **chage** (change age) adjusts user password aging rules, warning timelines, and account expiration deadlines.

### Q20: **Option A** — `iotop / iostat`

- **Deep Technical Rationale**: **iostat** and **iotop** monitor block device read/write transfer rates and disk subsystem latency.

### Q21: **Option B** — `It remains in the process table as a Zombie process (defunct)`

- **Deep Technical Rationale**: A **zombie process** has freed its memory allocations but keeps an entry in the kernel process table until its exit code is read.

### Q22: **Option B** — `tcpdump`

- **Deep Technical Rationale**: **tcpdump** is a packet sniffer utility used for network debugging, latency analysis, and traffic inspection.

### Q23: **Option A** — `sysctl / /etc/sysctl.conf`

- **Deep Technical Rationale**: **sysctl** configures Linux kernel parameters dynamically without rebooting, persisting changes via `/etc/sysctl.conf`.

### Q24: **Option A** — `ldd`

- **Deep Technical Rationale**: **ldd** (list dynamic dependencies) prints the shared objects (.so files) required by each program or library argument.
