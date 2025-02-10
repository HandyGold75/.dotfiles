#!/bin/bash

backupDir="/mnt/OneDrive_IZO/Backup/Servers"
tmpDir="/tmp/backup_sv"
runBackupDir(){
    if [ -z "$1" ] || [ -z "$2" ]; then
        return 1
    fi

    cd "${tmpDir:?}/$1" || cleanUp
    rm -fv "${backupDir:?}/$1/$2.tar.gz"
    tar -czhvf "${backupDir:?}/$1/$2.tar.gz" "./$2"
}

runBackup(){
    if [ -z "$1" ] || [ -z "$2" ]; then
        return 1
    fi

    # Fetch remote
    mkdir "${tmpDir:?}/$2" || cleanUp
    cd "${tmpDir:?}/$2" || cleanUp
    scp -rP 17522 "handygold75@$1:~/[!.]$3*" "${tmpDir:?}/$2" || cleanUp

    mkdir "${tmpDir:?}/$2/system" || cleanUp
    scp -rP 17522 "handygold75@$1:/etc/systemd/system/*.service" "${tmpDir:?}/$2/system" # No cleanup, non 0 exit if 1 permission error rises.

    if [ -n "$4" ]; then
        scp -rP 17522 "handygold75@$1:/$4" "${tmpDir:?}/$2" || cleanUp
    fi

    # Target folder
    rm -rf "${backupDir:?}/$2"
    mkdir "${backupDir:?}/$2" || cleanUp

    # Home files
    rm -fv "${backupDir:?}/$2/home.tar.gz"
    find ./ -maxdepth 1 -type f,l | tar -czhvf "${backupDir:?}/$2/home.tar.gz" -T -

    # Home folders
    for d in $(find ./ -maxdepth 1 -type d -printf "%f\n"); do
        if [[ "./" == *"$d"* ]]; then
            continue
        fi

        runBackupDir "$2" "$d" &
    done

    # Wait until complete
    for job in $(jobs -p); do
        wait "$job"
    done

    # Cleanup
    rm -rf "${tmpDir:?:?}/$2" || cleanUp
}

cleanUp(){
    rm -rf "${tmpDir:?}"
    exit
}

rm -rf "${tmpDir:?}"
mkdir "${tmpDir:?}" || cleanUp

runBackup "10.69.2.101" "SV01" "" "etc/nginx"
runBackup "10.69.2.102" "SV02" "[!mnt][!rclone]"
runBackup "10.69.2.103" "SV03"
runBackup "10.69.2.104" "SV04" "[!upload]"
runBackup "10.69.2.105" "SV05" "[!go][!venv]"
runBackup "10.69.2.106" "SV06"
runBackup "10.69.2.107" "SV07"

# Wait until complete
for job in $(jobs -p); do
    wait "$job"
done

runBackup "10.69.2.151" "GM01" "" "disk1"
runBackup "10.69.2.152" "GM02" "" "disk1"
runBackup "10.69.2.153" "GM03" "" "disk1"
runBackup "10.69.2.154" "GM04" "" "disk1"

cleanUp
