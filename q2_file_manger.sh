#!/bin/bash

while true
do
    echo
    echo "File Manager"
    echo "1. List files"
    echo "2. Create directory"
    echo "3. Create file"
    echo "4. Delete file"
    echo "5. Rename file"
    echo "6. Search file"
    echo "7. Count files and directories"
    echo "8. Exit"

    read -p "Choose option: " ch

    case $ch in

        1)
            ls -lh
            ;;

        2)
            read -p "Directory name: " dname
            if [ -d "$dname" ]
            then
                echo "Directory already exists."
            else
                mkdir "$dname"
                echo "Directory created."
            fi
            ;;

        3)
            read -p "File name: " fname
            if [ -f "$fname" ]
            then
                echo "File already exists."
            else
                touch "$fname"
                echo "File created."
            fi
            ;;

        4)
            read -p "Enter file to delete: " fname
            if [ -f "$fname" ]
            then
                read -p "Confirm delete (y/n): " ans
                if [ "$ans" = "y" ]
                then
                    rm "$fname"
                    echo "File deleted."
                else
                    echo "Cancelled."
                fi
            else
                echo "File not found."
            fi
            ;;

        5)
            read -p "Old file name: " old
            if [ -f "$old" ]
            then
                read -p "New file name: " new
                mv "$old" "$new"
                echo "Renamed successfully."
            else
                echo "File not found."
            fi
            ;;

        6)
            read -p "Enter name to search: " search
            find . -name "$search"
            ;;

        7)
            fcount=$(find . -type f | wc -l)
            dcount=$(find . -type d | wc -l)
            echo "Files: $fcount"
            echo "Directories: $dcount"
            ;;

        8)
            echo "Exiting..."
            break
            ;;

        *)
            echo "Invalid option."
            ;;
    esac

done 
