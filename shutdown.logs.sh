#!/bin/bash
# Run before shutdown: ./led_check.sh
# Check log after reboot

log=shutdown_investigate.log
> $log

echo "Kernel: $(uname -r)" >> $log
echo "ACPI errors:" >> $log
dmesg | grep -i acpi >> $log
echo "Power state:" >> $log
cat /sys/power/state >> $log
echo "Mem sleep:" >> $log
cat /sys/power/mem_sleep >> $log
echo "Last shutdown logs:" >> $log
journalctl -b -1 -u init.scope >> $log 2>&1

echo "Log saved to $log. Now shutting down..."
sudo poweroff