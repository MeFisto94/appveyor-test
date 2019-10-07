cd /c/openjdk/openjdk
PATH="/usr/bin:$PATH:/mingw/bin:/mingw/msys/1.0/bin/"
MSYSTEM=MINGW32

#Only required on msys2:, but msys2 fails the fixpath.c compilation anyway as of now.
#echo "Installing ZIP"
#pacman -Sy --noconfirm zip

echo [CONFIGURE]: Generating configure.
./common/autoconf/autogen.sh

echo Linking in the Compiler under /tmp/tools. This is because Autoconf does not support paths with spaces
#ln -s "/c/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.12.25827/bin/HostX64/x64/" /tmp/tools
ln -s "/c/Program Files (x86)/Microsoft Visual Studio 14.0/VC/bin/amd64/" /tmp/tools
./configure --prefix=/mingw TOOLS_DIR="/tmp/tools" --with-freetype-include="../../freetype-2.8/include/" --with-freetype-lib="../../freetype-2.8/objs/win64/vc2010" PLATFORM_WINMD='/AI"C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\lib\store\references\platform.winmd"' --disable-precompiled-headers
echo [COMPILING]
# We intentionally launch make twice as in the buildenv the first make fails with some javac problems which were unreproducable locally.
# oddly enough a second make invocation seems to be enough.
USE_PRECOMPILED_HEADER=0 make || USE_PRECOMPILED_HEADER=0 make
