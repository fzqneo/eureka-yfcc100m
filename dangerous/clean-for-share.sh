# general
find /root/.*history /home/*/.*history -exec rm -f {} \;
find / -name "authorized_keys" -exec rm -f {} \;

# server general
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub

# Diamond server specific
rm -f /home/diamond/.docker/config.json
rm -f /home/diamond/.diamond/log/*
rm -r /home/diamond/.diamond/cache/*

# Diamond client specific
rm -rf ~/opendiamond-logs/*

# this repo specific
rm -f ~/.aws/credentials