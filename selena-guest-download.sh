#!/usr/bin/env bash


#download vm images
for image in "0Byi7sMTL0nJiY2RrU3VuVkVVdnM-mrc2Template_host.xva" "0Byi7sMTL0nJiTHNDRkd3NlBDRzA-mrc2Template_ofctl.xva" "0Byi7sMTL0nJiS1VKYzdSZVB6bU0-mrc2Template_switch.xva"; do
    gooid=`echo $image | cut -d \- -f 1`
    filename=`echo $image | cut -d \- -f 2`
    echo "downloading $filename with gooid $gooid"
    confirm=`curl -c cookie.txt https://drive.google.com/uc\?id\=$gooid\&export\=download | grep -o 'confirm=.\{4\}' | cut -d = -f 2`
    echo "curl -c cookie.txt https://drive.google.com/uc\?id\=$gooid\&export\=download | grep -o 'confirm=.\{4\}' | cut -d = -f 2"
    curl -L -b cookie.txt https://drive.google.com/uc\?id\=$gooid\&export\=download\&confirm\=$confirm > $filename
    sudo xe vm-import filename=$filename
    rm $filename
    rm cookie.txt
done

sudo mkdir -p /boot/guest/
#download kernel files for selena guests
for image in "0Byi7sMTL0nJiM2p6bzk5emFmdmc;initrd.img-3.10.11-1tdf-amd64" "0Byi7sMTL0nJicTA4WTlSQWxEUG8;vmlinuz-3.10.11-1tdf-amd64"; do
    gooid=`echo $image | cut -d \; -f 1`
    filename=`echo $image | cut -d \; -f 2`
    echo "downloading $filename with gooid $gooid"
    confirm=`curl -c cookie.txt https://drive.google.com/uc\?id\=$gooid\&export\=download | grep -o 'confirm=.\{4\}' | cut -d = -f 2`
    curl -L -b cookie.txt https://drive.google.com/uc\?id\=$gooid\&export\=download\&confirm\=$confirm > $filename
    sudo mv $filename /boot/guest/
    if [ -e $filename ]; then rm $filename; fi
    rm cookie.txt
done
