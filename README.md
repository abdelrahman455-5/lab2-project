# Simple Antivirus Daemon

## Overview
This project contains a simple antivirus shell script daemon and a restore tool. The hierarchy contains `antivirusd.sh`, `restore.sh`, and a `Makefile`.

## Prerequisites
- Ubuntu Linux environment.
- Basic standard tools installed (bash, grep, diff/cmp, make). No extra packages are needed.

## Running Instructions
1. Create a directory to watch: `mkdir watch_dir`
2. Start the daemon using make: `make run-antivirus`
3. In a separate terminal window, open the restore tool: `make run-restore`

## Malicious Lists Locations
- Flagged extensions (.exe, .bat, .vbs, .scr, .ps1) are hardcoded in `antivirusd.sh` inside the `case "$filename"` statement.
- Flagged keywords (virus, trojan, malware, worm, ransomware) are hardcoded in `antivirusd.sh` inside the `grep -qiE` command.
