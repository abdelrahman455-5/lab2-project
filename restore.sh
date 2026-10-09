#!/bin/bash
DIR=$1
MAL_DIR=$2

while true; do
    if [ -z "$(ls -A "$MAL_DIR")" ]; then
        echo "No malicious files to review."
        exit 0
    fi

    echo "Files in quarantine:"
    ls -1 "$MAL_DIR" | cat -n

    read -p "Enter file number to review (or 0 to exit): " choice

    if [ "$choice" -eq 0 ]; then
        exit 0
    fi

    file=$(ls -1 "$MAL_DIR" | sed -n "${choice}p")

    if [ -z "$file" ]; then
        echo "Invalid choice."
        continue
    fi

    echo "1: Restore this file back into dir (it was a false positive)"
    echo "2: Permanently delete this file from malicious_dir (it was genuinely malicious)"
    echo "3: Leave this file as-is and go back to the list"
    read -p "Choose an option: " option

    case $option in
        1)
            mv "$MAL_DIR/$file" "$DIR/"
            echo "Restored $file to $DIR."
            ;;
        2)
            rm "$MAL_DIR/$file"
            echo "$file permanently deleted."
            ;;
        3)
            continue
            ;;
    esac
done
