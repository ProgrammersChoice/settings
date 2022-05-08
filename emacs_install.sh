git clone https://github.com/emacs-mirror/emacs
cd emacs

sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get install gcc-10 g++-10 libgccjit0 libgccjit-10-dev libjansson4 libjansson-dev libcurl4-openssl-dev
export CC=/usr/bin/gcc-10 CXX=/usr/bin/g++-10
./autogen.sh
./configure --with-native-compilation
make -j4
sudo make install
emacs --version  # shows GNU Emacs 28.0.50
sudo ln -f ~/.emacs.d/exwm/EXWM.desktop /usr/share/xsessions/EXWM.desktop

git clone --recursive https://github.com/polybar/polybar
cd polybar
git checkout 3.5.2
./build.sh



