@ECHO OFF
REM call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"

echo Building LibFreeType 2.8
pushd C:\freetype-2.8\builds\windows\vc2010\
patch < C:\openjdk\libfreetype.patch
MSBuild freetype.sln /property:Platform="x64" /property:Configuration=Release
MSBuild freetype.sln /property:Platform="x64" /property:Configuration="Release Multithreaded"
patch < C:\openjdk\libfreetype-2.8-dll.patch
echo Since App Veyors v100 Buildchain seems damaged, use the Windows 7.1 SDK to build libfreetype
patch < C:\openjdk\libfreetype-2.8-dll-platform-toolset.patch
MSBuild freetype.sln /property:Platform="x64" /property:Configuration=Release
MSBuild freetype.sln /property:Platform="x64" /property:Configuration="Release Multithreaded"
popd

git clone https://github.com/MeFisto94/openjdk
C:\msys64\msys2_shell.cmd -mingw64 -c "/c/openjdk/openjdk/common/autoconf/autogen.sh; exit"

REM C:\MinGW\msys\1.0\msys.bat
REM Both are wrong: The upper can't enter stuff and the lower misses some environment....
set MSYSTEM=MINGW32
C:\MinGW\msys\1.0\bin\bash.exe -c "/c/openjdk/build.sh"
REM C:\msys64\msys2_shell.cmd -mingw64 -c "$APPVEYOR_BUILD_FOLDER/build.sh; exit"
