sudo apt update

sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER

sudo apt install -y vagrant

sudo apt install -y ruby-dev build-essential libvirt-dev zlib1g-dev

vagrant plugin install vagrant-libvirt


#vagrant box add debian/bookworm64
