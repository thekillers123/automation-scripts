#
# The purpose of this script:
#     1) Install chocolatey
#     2) Use chocolatey to install all the packages I need
#
# By: Zach Peng
# https://zpeng.me
#

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

"
Install Tools:
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
    choco install ccleaner 7zip ghostscript visualstudiocode mendeley hyper screentogif
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
Install Calibre
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install calibre
}

"
Install Typora
"
$ANS = Read-Host -Prompt '[Y]es or [N]o?'
if ($ANS -eq "Y" -or $ANS -eq "y") {
    choco install typora
}

"If you don't want to use chocolatey to update a package, delete the corresponding folder under <C:\ProgramData\chocolatey\lib>."

$ANS = Read-Host -Prompt 'Press any key to exit'

# Install the following softwares through Microsoft Store
#
# - Inkscape
# - Trello
# - Ditto
# - paint.net
# - Gravit Designer
# - Snipaste
# - Slack
# - Telegram

