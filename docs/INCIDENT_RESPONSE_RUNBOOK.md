# Linux Incident Response Runbook & Diagnostics Guide

This runbook outlines standard operating procedures (SOP) for troubleshooting high-severity production outages on Linux hosts.

---

## 1. High CPU Utilization Outage
### Symptoms
- Load average exceeds CPU core count (e.g., load avg > 16 on an 8-core box).
- Latency spikes on application endpoints.

### Diagnostic Flow
1. Check overall metrics:
   ```bash
   top -b -n 1 | head -n 20
   uptime
   ```
2. Identify offending processes by CPU consumption:
   ```bash
   ps -eo pid,user,%cpu,%mem,command --sort=-%cpu | head -n 15
   ```
3. Trace system calls on the thread:
   ```bash
   strace -p <PID> -c
   ```
4. Mitigation:
   ```bash
   # Lower process scheduling priority
   renice +10 -p <PID>
   # Or terminate cleanly
   kill -15 <PID>
   # If non-responsive after 10s:
   kill -9 <PID>
   ```

---

## 2. Memory Exhaustion & OOM Killer Outages
### Symptoms
- Kernel terminates critical services (`Out of memory: Kill process`).
- `dmesg` contains `oom-killer` events.

### Diagnostic Flow
1. Check current memory state:
   ```bash
   free -h
   vmstat 1 5
   ```
2. Identify top memory hogs:
   ```bash
   ps -eo pid,user,%mem,rss,args --sort=-rss | head -n 15
   ```
3. Inspect kernel OOM invocations:
   ```bash
   journalctl -k | grep -i -E "oom[- ]killer|killed process"
   dmesg -T | grep -i oom
   ```
4. Adjust OOM score for protected daemons (prevent killing DB/app):
   ```bash
   echo -1000 > /proc/<PID>/oom_score_adj
   ```

---

## 3. Disk Full (100% Inodes or Blocks)
### Symptoms
- Applications crash with `No space left on device`.
- Database write operations fail.

### Diagnostic Flow
1. Check block utilization:
   ```bash
   df -h
   ```
2. Check inode exhaustion (many small files):
   ```bash
   df -i
   ```
3. Locate the largest culprit directories:
   ```bash
   du -ahx /var | sort -rh | head -n 20
   ```
4. Check for deleted open files still holding storage space:
   ```bash
   lsof | grep deleted | head -n 20
   # Restart the holding process to release space
   systemctl restart <holding_service>
   ```

---

## 4. Network Connectivity & Socket Starvation
### Diagnostic Flow
1. Check open listening sockets and backlog queues:
   ```bash
   ss -tulpn
   ss -s
   ```
2. Test network latency, DNS resolution, and routing:
   ```bash
   dig +short google.com
   ip route show
   traceroute -n 8.8.8.8
   ```
3. Check firewall dropped packets:
   ```bash
   journalctl -k | grep -i "UFW BLOCK"
   ```
