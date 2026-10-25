# 🎓 Linux Masterclass Quiz (24 Questions & Complete Answer Key)

Test your complete Linux administration skills across permissions, processes, systemd, and networking.

### Questions
1. **Which Linux directory stores global system configuration files?**
   - A) `/bin`
   - B) `/etc` (Correct)
   - C) `/var`
   - D) `/usr`
   - *Explanation:* Host-specific system-wide configuration files reside in `/etc`.

2. **What does the numeric permission 755 represent?**
   - A) User: rwx, Group: r-x, Others: r-x (Correct)
   - B) User: rw-, Group: rw-, Others: r--
   - C) User: r--, Group: -w-, Others: --x
   - D) User: rwx, Group: rw-, Others: -w-
   - *Explanation:* 7 (4+2+1), 5 (4+1), 5 (4+1).

3. **Which command safely displays kernel version and system architecture?**
   - A) `sysinfo`
   - B) `uname -a` (Correct)
   - C) `kernel --version`
   - D) `arch --show`

4. **What is the standard stream file descriptor for stderr?**
   - A) 0
   - B) 1
   - C) 2 (Correct)
   - D) 3

5. **Which command redirects both stdout AND stderr to output.log?**
   - A) `cmd > output.log 2>&1` (Correct)
   - B) `cmd 1>&2 output.log`
   - C) `cmd >> 2> output.log`
   - D) `cmd | output.log`

6. **What is the difference between a hard link and a symbolic link?**
   - A) Hard links point to filenames; soft links point to sectors
   - B) Hard links share the same inode; soft links store target path strings (Correct)
   - C) Hard links cross filesystems; soft links cannot
   - D) Deleting a soft link deletes the target data

7. **Which signal is sent by 'kill -9' and cannot be blocked or ignored?**
   - A) SIGTERM (15)
   - B) SIGHUP (1)
   - C) SIGKILL (9) (Correct)
   - D) SIGINT (2)

8. **Which command reloads systemd service unit files after disk edits?**
   - A) `systemctl reload-all`
   - B) `systemctl daemon-reload` (Correct)
   - C) `service systemd restart`
   - D) `init 6`

9. **How do you stream real-time logs for a systemd service named 'nginx'?**
   - A) `cat /var/log/nginx.log -f`
   - B) `journalctl -u nginx -f` (Correct)
   - C) `systemctl log nginx -r`
   - D) `service logs nginx --live`

10. **Which modern tool replaces netstat for inspecting listening TCP/UDP ports?**
    - A) `ss -tulpn` (Correct)
    - B) `ip route show`
    - C) `ifconfig -a`
    - D) `traceroute -p`

11. **What does the sticky bit (chmod 1777 /tmp) prevent?**
    - A) Reading files in the folder
    - B) Writing files in the folder
    - C) Users from deleting files owned by other users (Correct)
    - D) Executing scripts

12. **What is the recommended permission for ~/.ssh/authorized_keys?**
    - A) 777
    - B) 755
    - C) 600 (Correct)
    - D) 644

13. **Which key combination pauses a foreground Bash job and returns to prompt?**
    - A) Ctrl + C
    - B) Ctrl + Z (Correct)
    - C) Ctrl + D
    - D) Ctrl + L

14. **What does the cron schedule '*/15 * * * *' specify?**
    - A) At 15:00 every day
    - B) Every 15 minutes (Correct)
    - C) On the 15th of the month
    - D) Every 15 seconds

15. **Which command searches recursively for 'DATABASE_URL' with line numbers?**
    - A) `find . -name 'DATABASE_URL'`
    - B) `grep -rn 'DATABASE_URL' .` (Correct)
    - C) `locate DATABASE_URL`
    - D) `whereis DATABASE_URL`

16. **Which command creates a compressed tar archive backup.tar.gz from data/?**
    - A) `tar -xzvf backup.tar.gz data/`
    - B) `tar -czvf backup.tar.gz data/` (Correct)
    - C) `zip -tar data/ backup.tar.gz`
    - D) `gzip -c data/ > backup.tar.gz`

17. **What does 'export PATH=$PATH:/opt/myapp/bin' do?**
    - A) Overwrites system path
    - B) Appends /opt/myapp/bin to current search PATH (Correct)
    - C) Deletes /opt/myapp/bin
    - D) Copies binaries to /usr/bin

18. **Which virtual filesystem exposes live kernel process and RAM stats?**
    - A) `/proc` (Correct)
    - B) `/boot`
    - C) `/srv`
    - D) `/media`

19. **Which command shows human-readable disk usage across all filesystems?**
    - A) `free -h`
    - B) `df -h` (Correct)
    - C) `du -sh /`
    - D) `lsblk -f`

20. **What is the primary function of 'nohup'?**
    - A) Run as root
    - B) Prevents process from terminating on SIGHUP when shell disconnects (Correct)
    - C) Multi-core acceleration
    - D) SSL traffic encryption

21. **In Bash, what does '$?' evaluate to?**
    - A) PID of shell
    - B) Exit status code of last command (Correct)
    - C) Argument count
    - D) Current username

22. **With a umask of 022, what permission is assigned to newly created files?**
    - A) 755
    - B) 644 (Correct)
    - C) 666
    - D) 700

23. **Which stream processing tool extracts the 3rd whitespace column?**
    - A) `sed`
    - B) `awk '{print $3}'` (Correct)
    - C) `grep -3`
    - D) `tr`

24. **What is the difference between 'apt update' and 'apt upgrade'?**
    - A) 'apt update' refreshes package lists; 'apt upgrade' downloads/installs newer versions (Correct)
    - B) 'apt update' installs; 'apt upgrade' removes
    - C) 'apt update' restarts server; 'apt upgrade' configures firewall
    - D) Identical commands
