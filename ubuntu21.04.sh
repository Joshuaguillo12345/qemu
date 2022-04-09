apt update
wget http://www.releases.ubuntu.com/21.04/ubuntu-21.04-desktop-amd64.iso
apt install qemu-system-x86
apt install qemu-utils
qemu-img create joshua.qcow2 20G
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip -o ngrok-stable-linux-amd64.zip > /dev/null 2>&1
clear
read -p "Paste authtoken here (Copy and Ctrl+V to paste then press Enter): " CRP
./ngrok authtoken $CRP 
nohup ./ngrok tcp 5900 &>/dev/null
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
qemu-system-x86_64 -vnc :0 -hda joshua.qcow2 -cdrom ubuntu-21.04-desktop-amd64.iso -smp cores=2  -m 3072M -machine usb=on -device usb-tablet > /dev/null 2>&1
