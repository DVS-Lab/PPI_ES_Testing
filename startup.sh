#Probably need to run at least one sudo command otherwise the script will get held up by requiring the root password
sudo file -s /dev/xvdf



#Mounts external drive to /data folder
sudo mkdir /data
sudo mount /dev/xvdf /data


#necessary to install things like dos2unix
PATH=/sbin:$PATH
export PATH

