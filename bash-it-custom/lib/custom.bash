export GRAILS_OPTS="-Xmx2G -Xms512m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8 -Djava.encoding=UTF-8"

export LC_ALL=da_DK.UTF-8


## Enables dual network at SKAT (WiFi must be at the top!)
function ccta() {
    sudo route -n delete 192.168.146.0 10.3.0.1 -netmask 255.255.255.0
    sudo route -n delete 172.20.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n delete 172.23.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n delete 172.24.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n add 192.168.146.0 10.3.0.1 -netmask 255.255.255.0
    sudo route -n add 172.20.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n add 172.23.0.0 10.3.0.1 -netmask 255.255.0.0
    sudo route -n add 172.24.0.0 10.3.0.1 -netmask 255.255.0.0
}