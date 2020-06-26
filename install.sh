sudo apt-get install python3-dev
sudo apt-get install ruby-dev
sudo apt-get install ruby
sudo apt-get install libncurses5-dev
sudo apt-get install golang
sudo apt-get install -y nodejs
sudo apt install npm
sudo apt intall yarn
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo sh -c "echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list"
sudo apt update
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository ppa:rafaeldtinoco/lp1871129
sudo apt update
sudo apt install libc6=2.31-0ubuntu8+lp1871129~1 libc6-dev=2.31-0ubuntu8+lp1871129~1 libc-dev-bin=2.31-0ubuntu8+lp1871129~1 -y --allow-downgrades
sudo apt-mark hold libc6
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo sh -c "echo 'deb https://dl.yarnpkg.com/debian/ stable main' >> /etc/apt/sources.list"
sudo apt update
sudo apt-get install yarn
sudo apt install fd-find
sudo apt-get install silversearcher-ag
sudo apt-get install ripgrep universal-ctags
sudo apt-get install fd-find
sudo apt install bat
sudo ln -s /usr/bin/batcat /usr/bin/bat
