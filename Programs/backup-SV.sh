#!/bin/bash

backupDir="/mnt/OneDrive_IZO/Backup/Servers"
runBackupDir(){
    if [ -z "$1" ]; then
        return 1
    fi

    cd ~/ || exit
    rm -fv "${backupDir}/$1.tar.gz"
    tar -czhvf "${backupDir}/$1.tar.gz" "./$1"
}

runBackup(){
    mkdir "$HOME/temp_backup/$2" || cleanUp
    cd "$HOME/temp_backup/$2" || cleanUp
    scp -rP 17520 [!.]* "handygold75@$1:~/" "$HOME/temp_backup/$2" || cleanUp

    rm -fv "${backupDir}/$2/home.tar.gz"
    find ./ -maxdepth 1 -type f,l | tar -czhvf "${backupDir}/$2/home.tar.gz" -T -

    for d in $(find ./ -maxdepth 1 -type d -printf "%f\n"); do
        if [[ "./|./.cache|./.wine|./.local|./.steam" == *"$d"* ]]; then
            continue
        fi
    
        runBackup "$2/$d" &
    done

    for job in $(jobs -p); do
        wait "$job"
    done

    rmdir "$HOME/temp_backup/$2"
}

cleanUp(){
	rm -rf ~/temp_backup
	exit
}

mkdir ~/temp_backup || cleanUp
cd ~/temp_backup || cleanUp

# runBackup "10.69.2.52" "SV02"
# runBackup "10.69.2.53" "SV03"
# runBackup "10.69.2.54" "SV04"
# runBackup "10.69.2.55" "SV05"
# runBackup "10.69.2.56" "SV06"
# runBackup "10.69.2.57" "SV07"
runBackup "10.69.2.58" "SV08"


# /etc/systemd/system

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV02/*
# scp -rP 17522 handygold75@10.69.2.52:/etc/systemd/system/OneDrive_IZO.service /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:/etc/systemd/system/GooglePhotos_IZO.service /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:/etc/systemd/system/SharePointStorage_IZO.service /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:/etc/systemd/system/BorgBackup.service /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/.config/rclone/rclone.conf /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/borgbackup.bin /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/borgbackup.json /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/borgbackup.log /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/OD.txt /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/SP.txt /mnt/OneDrive_IZO/Backup/Servers/SV02
# scp -rP 17522 handygold75@10.69.2.52:~/start.txt /mnt/OneDrive_IZO/Backup/Servers/SV02

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV03/*
# scp -rP 17522 handygold75@10.69.2.53:~/start.txt /mnt/OneDrive_IZO/Backup/Servers/SV03
# scp -rP 17522 handygold75@10.69.2.53:/etc/systemd/system/wsserver.service /mnt/OneDrive_IZO/Backup/Servers/SV03
# scp -rP 17522 handygold75@10.69.2.53:~/Websocket_Server /mnt/OneDrive_IZO/Backup/Servers/SV03

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV04/*
# scp -rP 17522 handygold75@10.69.2.54:~/start.txt /mnt/OneDrive_IZO/Backup/Servers/SV04
# scp -rP 17522 handygold75@10.69.2.54:/etc/systemd/system/qbserver.service /mnt/OneDrive_IZO/Backup/Servers/SV04
# scp -rP 17522 handygold75@10.69.2.54:~/torrentFiles /mnt/OneDrive_IZO/Backup/Servers/SV04

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV05/*
# scp -rP 17522 handygold75@10.69.2.55:~/start.txt /mnt/OneDrive_IZO/Backup/Servers/SV05
# scp -rP 17522 handygold75@10.69.2.55:/disk1/minecraft /mnt/OneDrive_IZO/Backup/Servers/SV05
# scp -rP 17522 handygold75@10.69.2.55:/etc/systemd/system/mcserver.service /mnt/OneDrive_IZO/Backup/Servers/SV05

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV06/*
# scp -rP 17522 handygold75@10.69.2.56:~/start.txt /mnt/OneDrive_IZO/Backup/Servers/SV06
# scp -rP 17522 handygold75@10.69.2.56:/disk1/terraria/Worlds /mnt/OneDrive_IZO/Backup/Servers/SV06
# scp -rP 17522 handygold75@10.69.2.56:/etc/systemd/system/trserver.service /mnt/OneDrive_IZO/Backup/Servers/SV06
# scp -rP 17522 handygold75@10.69.2.56:~/terraria /mnt/OneDrive_IZO/Backup/Servers/SV06

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV07/*
# scp -rP 17522 handygold75@10.69.2.57:~/start.txt /mnt/OneDrive_IZO/Backup/Servers/SV07
# scp -rP 17522 handygold75@10.69.2.57:~/update.txt /mnt/OneDrive_IZO/Backup/Servers/SV07
# scp -rP 17522 handygold75@10.69.2.57:/etc/systemd/system/trmserver.service /mnt/OneDrive_IZO/Backup/Servers/SV07
# scp -rP 17522 handygold75@10.69.2.57:/disk1/terraria_modded /mnt/OneDrive_IZO/Backup/Servers/SV07

# rm -r /mnt/OneDrive_IZO/Backup/Servers/SV08/*
# scp -rP 17522 handygold75@10.69.2.58:~/Repos /mnt/OneDrive_IZO/Backup/Servers/SV08
# scp -rP 17522 handygold75@10.69.2.58:~/.dotfiles /mnt/OneDrive_IZO/Backup/Servers/SV08

