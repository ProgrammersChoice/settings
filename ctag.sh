#!/bin/bash
echo "make tags ARCH=arm"
ctags -R
echo "make cscope ARCH=arm"
find ./ -name '*[cCsShH]'> file_list
find ./ -name '*.lds' >> file_list
find ./ -name '*.cc' >> file_list
find ./ -name '*.sh' >> file_list
find ./ -name '*.cpp' >> file_list
find ./ -name '*.inf' >> file_list
find ./ -name '*.dec' >> file_list
find ./ -name '*.dsc' >> file_list
find ./ -name '*.dts' >> file_list
find ./ -name '*.dtsi' >> file_list
find ./ -name '*.bat' >> file_list
find ./ -name '*.sh' >> file_list
find ./ -name '*config' >> file_list
find ./ -name '*defconfig' >> file_list
find ./ -name 'Makefile' >> file_list
sed '/arch\/[b-z]/d' file_list > file_list2
sed '/arch\/avr/d' file_list2 > file_list
sed '/arch\/arc/d' file_list > file_list2
sed '/arch\/alpha/d' file_list2 > file_list
rm -rf file_list2
cscope -i file_list
rm -rf file_list
