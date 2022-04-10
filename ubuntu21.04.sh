echo "Tải xuống các tệp windows"
wget -O ubuntu.iso http://www.releases.ubuntu.com/hirsute/ubuntu-21.04-desktop-amd64.iso
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
read -p "Ctrl + V Authtoken(nhập token ngrok): " CRP 
./ngrok authtoken $CRP 
nohup ./ngrok tcp 5900 &>/dev/null &
echo Tải xuống tệp từ sever
apt-get install qemu
apt-get install qemu-utils
qemu-img create joshua.qcow2 30G
echo "Đợi"
echo "Khởi động Windows"
echo RDP Địa chỉ:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Ctrl+C để Copy"
echo "Đợi 1-2 Phút để hoàn thành thiết lập"
echo "Không đóng tab này"
echo "hãy ủng hộ Hoàng vtmc xin cảm ơn"
qemu-system-x86_64 -hda joshua.qcow2 -cdrom ubuntu.iso -m 8G -smp cores=4 -net user,hostfwd=tcp::5900-:5900 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga vmware -nographic
sleep 43200
