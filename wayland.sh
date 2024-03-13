sudo apt install ydotool
sudo apt install ydotoold
sudo usermod -aG users $USER
sudo cp 01-uinput-permission.rules /etc/udev/rules.d/01-uinput-permission.rules
sudo cp uinput.conf /etc/modules-load.d/uinput.conf
echo Vous devez redémarrer pour que les modifications soient effectives.