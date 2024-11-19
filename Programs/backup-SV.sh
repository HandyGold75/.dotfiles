#!/bin/bash

backupDir="/mnt/OneDrive_IZO/Backup/Servers"
runBackupDir(){
    if [ -z "$2" ]; then
        return 1
    fi

    cd "$HOME/temp_backup/$1" || cleanUp
    rm -fv "${backupDir}/$1/$2.tar.gz"
    tar -czhvf "${backupDir}/$1/$2.tar.gz" "./$2"
}

runBackup(){
    # Fetch remote
    mkdir "$HOME/temp_backup/$2" || cleanUp
    cd "$HOME/temp_backup/$2" || cleanUp
    scp -rP 17522 "handygold75@$1:~/[!.]$3*" "$HOME/temp_backup/$2" || cleanUp

    mkdir "$HOME/temp_backup/$2/system" || cleanUp
    scp -rP 17522 "handygold75@$1:/etc/systemd/system/*.service" "$HOME/temp_backup/$2/system"

    if [ -n "$4" ]; then
        scp -rP 17522 "handygold75@$1:/$4" "$HOME/temp_backup/$2" || cleanUp
    fi

    # Target folder
    rm -rf "${backupDir:?}/$2"
    mkdir "${backupDir}/$2" || cleanUp

    # Home files
    rm -fv "${backupDir}/$2/home.tar.gz"
    find ./ -maxdepth 1 -type f,l | tar -czhvf "${backupDir}/$2/home.tar.gz" -T -

    # Folders
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
    rm -rf "$HOME/temp_backup/$2" || cleanUp
}

cleanUp(){
    rm -rf ~/temp_backup
    exit
}

rm -rf ~/temp_backup
mkdir ~/temp_backup || cleanUp

runBackup "10.69.2.52" "SV02" "[!mnt][!rclone]"
runBackup "10.69.2.53" "SV03" "" "disk1"
runBackup "10.69.2.54" "SV04" "[!upload]"
runBackup "10.69.2.56" "SV06" "" "disk1"
runBackup "10.69.2.57" "SV07" "" "disk1"
runBackup "10.69.2.58" "SV08" "[!go]"
runBackup "10.69.2.60" "SV10" "" "disk1"

# Wait until complete
for job in $(jobs -p); do
    wait "$job"
done

runBackup "10.69.2.55" "SV05" "" "disk1"

rm -rf ~/temp_backup

