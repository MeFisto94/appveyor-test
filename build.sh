git clone https://github.com/MeFisto94/openjdk
cd openjdk
common/autoconf/autogen.sh

echo "Installing ZIP"
pacman -Sy --noconfirm zip

echo Linking in the Compiler under /tmp/tools. This is because Autoconf does not support paths with spaces
ln -s "/c/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.12.25827/bin/HostX64/x64/" /tmp/tools
./configure --prefix=/mingw TOOLS_DIR="/tmp/tools" --with-freetype-include="../../freetype-2.8/include/" --with-freetype-lib="../../freetype-2.8/objs/vc2010/x64"