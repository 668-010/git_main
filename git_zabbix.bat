echo on
:: GIT Service Updater - обновляет другие сервисы обновлений GIT. Первоочередно для обновления GIT Zabbix Mod & Shell
:: Для батников запускаемых с высокими привилегиями, перед выполнением любых действий обязателен переход на папку с файлом или выполняемым пакетом.
:: С помощью текстового браузера lynx смотрим версию zabbix_mod в нашем интернет-репозитории и записываем в файл.
cd "C:\Program Files\GIT Main Updater\lynx"
"C:\Program Files\GIT Main Updater\lynx\lynx.exe" -source https://raw.githubusercontent.com/668-010/git_zabbix/master/version.txt > "C:\Program Files\GIT Main Updater\tmp\git_zabbix_version.txt"

:: Переходим в папку куда записали версию и сравниваем с имеющейся версией в системе.
cd "C:\Program Files\GIT Main Updater\tmp"
fc /W "C:\Program Files\GIT Main Updater\tmp\git_zabbix_version.txt" "C:\Program Files\GIT\version.txt" > nul

:: Если содержимое файлов отличается (значение 1) то переход на выполнение команд в скобках
if errorlevel 1 goto git_zabbix
goto no_update

:git_zabbix
	
:: Переход в папку tmp и удаляем старый архив.
	cd "C:\Program Files\GIT Main Updater\tmp\"
	del /f /q "C:\Program Files\GIT Main Updater\tmp\git_zabbix.zip"
		
:: Переход в папку с пакетом WGET и с помощью него с параметрами игнорирования сертификата HTTPS скачиваем новый архив в папку tmp		
	cd "C:\Program Files\GIT Main Updater\wget\bin"
	"C:\Program Files\GIT Main Updater\wget\bin\wget.exe" --no-check-certificate -c https://github.com/668-010/git_zabbix/archive/master.zip -O "C:\Program Files\GIT Main Updater\tmp\git_zabbix.zip"

:: Делаем маленький таймаут с помощью пинга		
	ping -n 3 127.0.0.1 > nul
			
:: Переход в папку с пакетом архиватора 7z и извлечение скачанного архива в папку C:\zabbix-agent
	cd "C:\Program Files\GIT Main Updater\zip"
	"C:\Program Files\GIT Main Updater\zip\7z.exe" x "C:\Program Files\GIT Main Updater\tmp\git_zabbix.zip" -o"C:\Program Files\GIT Main Updater\tmp\"
		
:: Переход в папку заббикс-агента, таймаут, и копируем содержимое извлчеченного архива в папку с заббикс модами, с параметрами (скрытые, без подтверждения, с каталогами и т.п.)		
	cd "C:\Program Files"
	ping -n 3 127.0.0.1 > nul
	xcopy "C:\Program Files\GIT Main Updater\tmp\git_zabbix-master" "C:\Program Files\GIT\" /H /Y /C /R /S /I

:: Таймаут и запуск службы Заббикс агент
	ping -n 6 127.0.0.1 > nul
	
:: Пишем в лог что обновились заббикс модули
	cd "C:\Program Files\GIT Main Updater\log"
	echo ============================================ >> "C:\Program Files\GIT Main Updater\log\log.txt"
	echo "Zabbix modules updated a new version  (%date%   %time%)" >> "C:\Program Files\GIT Main Updater\log\log.txt"
	echo ============================================ >> "C:\Program Files\GIT Main Updater\log\log.txt"

:: Удаляем папку ранее извлеченного архива
	rmdir /s /q "C:\Program Files\GIT Main Updater\tmp\git_zabbix-master"
	
	goto run_git_zabbix

:: Иначе (если файлы версий совпадают то пишем в лог что нет обновления)		
:no_update
	echo no mod updates
	cd "C:\Program Files\GIT Main Updater\log"
	echo ============================================ >> "C:\Program Files\GIT Main Updater\log\log.txt"
	echo "Zabbix modules not updated (%date%    %time%)" >> "C:\Program Files\GIT Main Updater\log\log.txt"
	echo ============================================ >> "C:\Program Files\GIT Main Updater\log\log.txt"

	
:run_git_zabbix
	:: Переход в папку с пакетами GIT и запускаем бат проверки обновлений компонентов заббикс модулей с ожиданием его окончания
	cd "C:\Program Files\GIT\"
	call "C:\Program Files\GIT\git.bat"
	exit