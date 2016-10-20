net stop "Zabbix Agent"
xcopy "C:\Program Files\GIT Main Updater\bin" "C:\zabbix-agent\bin" /H /Y /C /R /S /I
RD /S /Q "C:\Program Files\GIT Main Updater\bin"
net start "Zabbix Agent"