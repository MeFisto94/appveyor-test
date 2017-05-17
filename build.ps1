. .\degzip.ps1
(New-Object Net.WebClient).DownloadFile('http://download.savannah.gnu.org/releases/freetype/freetype-2.8.tar.gz', 'C:\FT.tar.gz')
DeGZip-File 'C:\FT.tar.gz'