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
if ($ANS -eq "Y" -or $ANS -eq "y") {
    # choco install adobereader-update
    choco install foxitreader ccleaner 7zip ghostscript visualstudiocode mendeley hyper screentogif
}

"
Install git:
- GitKraken
- GitHub
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install gitkraken github-desktop
}

"
Install Android Studio
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install androidstudio
}

"
Install Python
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install anaconda3 pycharm-community
}

"
Install Node.js
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install nodejs
}

"
Install Teamviewer
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install teamviewer
}

"
Microsoft Store Apps:
- Inkscape
- Trello
- Ditto
- paint.net
- Gravit Designer
- Snipaste
- Slack
- Telegram
"

