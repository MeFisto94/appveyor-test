. .\degzip.ps1
(New-Object Net.WebClient).DownloadFile('http://download.savannah.gnu.org/releases/freetype/freetype-2.8.tar.gz', 'C:\FT.tar.gz')
# DeGZip-File 'C:\FT.tar.gz'
# Use 7zip for this...
PUSHD C:\
cmd.exe /c 7zip e C:\FT.tar.gz
cmd.exe /c 7zip x C:\FT.tar
DEL /F C:\FT.tar FT.tar.gz
POPD