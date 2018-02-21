REM call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"
REM C:\MinGW\msys\1.0\msys.bat
REM Both are wrong: The upper can't enter stuff and the lower misses some environment....
C:\MinGW\msys\1.0\bin\bash.exe -c "C:\openjdk\build.sh"
REM C:\msys64\msys2_shell.cmd -mingw64 -c "$APPVEYOR_BUILD_FOLDER/build.sh; exit"