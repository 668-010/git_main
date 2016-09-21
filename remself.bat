ping -n 3 127.0.0.1 > nul

:: Удаляем временный батник.
cd "C:\Program Files\GIT Main Updater\tmp\"
del /f /q "C:\Program Files\GIT Main Updater\tmp\self-renewal.bat"

:: Запускаем проверку обновлений других компонентов
cd "C:\Program Files\GIT Main Updater\"
call /k "C:\Program Files\GIT Main Updater\komponents_updater.bat"
exit