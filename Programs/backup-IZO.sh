#!/bin/bash

backupDir="/mnt/OneDrive_IZO/Backup/WSIZ00"
runBackup(){
    if [ -z "$1" ]; then
        return 1
    fi

    cd ~/ || exit
    rm -fv "${backupDir}$1.tar.gz"
    tar -czhvf "${backupDir}$1.tar.gz" "./$1"
}

cd ~/ || exit
rm -fv "${backupDir}home.tar.gz"
find ./ -maxdepth 1 -type f,l | tar -czhvf "${backupDir}home.tar.gz" -T -

for d in $(find ./ -maxdepth 1 -type d -printf "%f\n"); do
    if [[ "./|./.cache|./.local" == *"$d"* ]]; then
        continue
    fi

    runBackup "$d" &
done

for job in $(jobs -p); do
    wait "$job"
done
