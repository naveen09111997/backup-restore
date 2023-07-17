#!/bin/bas

cd /home/iplon/Backup/

find -mtime +7 -delete

rsync -a backup_20230622.tar.gz root@192.168.1.31:~/Backup
