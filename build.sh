cd openjdk

#Only required on msys2:, but msys2 fails the fixpath.c compilation anyway as of now.
#echo "Installing ZIP"
#pacman -Sy --noconfirm zip

echo Linking in the Compiler under /tmp/tools. This is because Autoconf does not support paths with spaces
#ln -s "/c/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.12.25827/bin/HostX64/x64/" /tmp/tools
ln -s "/c/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/amd64/" /tmp/tools
./configure --prefix=/mingw TOOLS_DIR="/tmp/tools" --with-freetype-include="../../freetype-2.8/include/" --with-freetype-lib="../../freetype-2.8/objs/vc2010/x64"
