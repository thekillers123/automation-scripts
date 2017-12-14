Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Can be installed from Windows Store
# choco install ditto

# choco install wox

"
Install Tools:
- Foxit Reader
- CCleaner
- 7zip
- GhostScript
- VSCode
- Mendeley
- Hyper
- Screentogif
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y")
{
# choco install adobereader-update
choco install foxitreader
choco install ccleaner
choco install 7zip
choco install ghostscript
choco install visualstudiocode
choco install mendeley
choco install hyper
choco install screentogif
}

"
Install git:
- GitKraken
- GitHub
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y")
{
choco install gitkraken
choco install github-desktop
}

"
Install Android Studio
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y")
{
choco install androidstudio
}

"
Install Python
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y")
{
choco install anaconda3
choco install pycharm-community
}

"
Install Node.js
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y")
{
choco install nodejs
}


