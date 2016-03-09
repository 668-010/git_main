ping -n 6 127.0.0.1 > nul
cd "C:\Program Files\GIT Main Updater\tmp\"
del /f /q "C:\Program Files\GIT Main Updater\tmp\self-renewall.bat"

cd "C:\Program Files\GIT Main Updater\"
start cmd /k "C:\Program Files\GIT Main Updater\komponents_updater.bat"
exit
echo starie