setlocal enabledelayedexpansion
set LANG=en-US
set default_import_path=C:\1.Dev\

for /f "tokens=1-9 delims=/:. " %%a in ("%date% %time%") do (
  set year=%%a
  set month=%%b
  set day=%%c
  set hour=%%e
  set minute=%%f
  set second=%%g
)

set datetime=%year%_%month%_%day%_%hour%_%minute%_%second%
set default_export_path=%CD%\%datetime%\
mkdir %default_export_path%

for /f %%a in (.\list.txt) do (
    set sys=%%a
    set sys=!sys:~0,3!
	set importPath=%default_import_path%\!sys!\%%a
	set exportPath=%default_export_path%\!sys!\%%a
	
	
	echo %date% %time% : %%a build >> %default_export_path%\log.txt
	echo dotnet build !importPath! -c Debug -o !exportPath! >> %default_export_path%\log.txt
	dotnet build !importPath! -c Debug -o !exportPath! | find "error" >> %default_export_path%\log.txt
	
	if not errorlevel 1 (
	
	    del /Q /F !exportPath!\*
	    echo %date% %time% : %%a Failed. >> %default_export_path%\log.txt
	) else (
	    echo %date% %time% : %%a Sucess. >> %default_export_path%\log.txt
	)


)