sudo apt-get install -y python3-dev
sudo apt-get install -y ruby-dev
sudo apt-get install -y ruby
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y golang
sudo apt-get install -y nodejs
sudo apt-get install -y zsh
sudo apt-get install -y curl
sudo apt install -y npm
sudo apt install -y yarn
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sudo sh -c "echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list"
sudo apt update
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository ppa:rafaeldtinoco/lp1871129
sudo apt update
sudo apt -y install libc6=2.31-0ubuntu8+lp1871129~1 libc6-dev=2.31-0ubuntu8+lp1871129~1 libc-dev-bin=2.31-0ubuntu8+lp1871129~1 -y --allow-downgrades
sudo apt-mark hold libc6
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo sh -c "echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list"
sudo apt update
sudo apt install -y dbus-x11
sudo apt-get -y install yarn
sudo apt install -y fd-find
sudo apt-get install -y silversearcher-ag
sudo apt-get install -y ripgrep universal-ctags
sudo apt-get install -y fd-find
sudo apt-get install -y xclip
sudo apt install -y bat
sudo apt-get install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev gnutls-dev libgtk-3-dev
sudo ln -s /usr/bin/batcat /usr/bin/bat
sudo apt install -y arandr autorandr
sudo apt install -y scrot brightnessctl playerctl compton feh libtool-bin
sudo apt install -y slock xss-lock
sudo apt install -y build-essential git cmake cmake-data pkg-config \
python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev \
libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto \
libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev clang
sudo apt install -y fonts-font-awesome fonts-material-design-icons-iconfont
sudo apt install -y lightdm fcitx-hangul
sudo apt install -y fonts-powerline nabi indicator-appmenu-tools mupdf

mkdir ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/naver/d2codingfont/releases/download/VER1.3.2/D2Coding-Ver1.3.2-20180524.zip
unzip D2Coding-Ver1.3.2-20180524.zip
fc-cache -f -v
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
sudo cp -R ./ ~/
