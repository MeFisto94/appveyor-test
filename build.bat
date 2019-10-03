@ECHO OFF
REM call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"

echo Building LibFreeType 2.8
pushd C:\freetype-2.8\builds\windows\vc2010\
patch < C:\openjdk\libfreetype.patch

echo [Building]: LibFreeType 32Bit .lib
MSBuild freetype.sln /property:Platform="win32" /property:Configuration="Release Multithreaded" /property:ConfigurationType="StaticLibrary"
echo [Building]: LibFreeType 32Bit .dll
MSBuild freetype.sln /property:Platform="win32" /property:Configuration="Release Multithreaded" /property:ConfigurationType="DynamicLibrary"

echo Applying Windows 7.1 SDK for the x64 build.
patch < C:\openjdk\libfreetype-2.8-dll-platform-toolset.patch

echo [Building]: LibFreeType 64Bit .lib
MSBuild freetype.sln /property:Platform="x64" /property:Configuration="Release Multithreaded" /property:ConfigurationType="StaticLibrary"
echo [Building]: LibFreeType 64bit .dll
MSBuild freetype.sln /property:Platform="x64" /property:Configuration="Release Multithreaded" /property:ConfigurationType="DynamicLibrary"

REM echo Since App Veyors v100 Buildchain seems damaged, use the Windows 7.1 SDK to build libfreetype
REM patch < C:\openjdk\libfreetype-2.8-dll.patch
popd

git clone https://github.com/MeFisto94/openjdk
REM C:\msys64\msys2_shell.cmd -mingw64 -c "/c/openjdk/openjdk/common/autoconf/autogen.sh; exit"
REM C:\MinGW\msys\1.0\msys.bat
REM Both are wrong: The upper can't enter stuff and the lower misses some environment....

cd C:\openjdk\openjdk\
echo [CONFIGURE]: Patching Autoconf Files!
patch -p0 < C:\openjdk\winmd.patch

REM According to https://github.com/docker/for-win/issues/262, bash.exe provides output when being launched from a powershell script.
PowerShell C:\MinGW\msys\1.0\bin\bash.exe -c "/c/openjdk/build.sh"
REM C:\msys64\msys2_shell.cmd -mingw64 -c "$APPVEYOR_BUILD_FOLDER/build.sh; exit"