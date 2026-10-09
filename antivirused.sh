#!/bin/bash
DIR=$1
MAL_DIR=$2
INTERVAL=$3

scan_files() {
    for file in "$DIR"/*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            is_malicious=0
            
            case "$filename" in
                *.exe|*.bat|*.vbs|*.scr|*.ps1) is_malicious=1 ;;
            esac
            
            if grep -qiE "virus|trojan|malware|worm|ransomware" "$file"; then
                is_malicious=1
            fi
            
            if [ $is_malicious -eq 1 ]; then
                echo "$filename is malicious and it is DELETED"
                cp "$file" "$MAL_DIR/"
                rm "$file"
            fi
        fi
    done
}

scan_files
ls -l "$DIR" > directory-info.last

while true; do
    sleep "$INTERVAL"
    ls -l "$DIR" > directory-info.new
    
    if ! cmp -s directory-info.last directory-info.new; then
        scan_files
        cp directory-info.new directory-info.last
    fi
done
