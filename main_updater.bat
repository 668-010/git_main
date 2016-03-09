echo on
:: GIT Service Updater - обновляет другие сервисы обновлений GIT. Первоочередно для обновления GIT Zabbix Mod & Shell
:: Для батников запускаемых с высокими привилегиями, перед выполнением любых действий обязателен переход на папку с файлом или выполняемым пакетом.

echo starie
cd "C:\Program Files\GIT Main Updater\"
copy /y "C:\Program Files\GIT Main Updater\self-renewal.bat" "C:\Program Files\GIT Main Updater\tmp\self-renewal.bat"
ping -n 6 127.0.0.1 > nul
cd "C:\Program Files\GIT Main Updater\tmp"
start cmd /k "C:\Program Files\GIT Main Updater\tmp\self-renewal.bat"
exit