@echo off
:: Prompt UAC if script is not elevated
:: (fltmc needs admin and, unlike "net session", doesn't depend on the Server service)
fltmc >nul 2>&1
if errorlevel 1 (
	:: already tried elevating once? stop instead of looping forever
	if "%~1"=="elevated" (
		echo Could not obtain administrator rights. Right-click run.bat and choose "Run as administrator".
		pause
		exit /b 1
	)
	powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList 'elevated' -Verb RunAs"
	exit /b
)

:: Set variables
set "BATCH_FOLDER=%~dp0"
set "ICONS_SOURCE=%BATCH_FOLDER%Icon"
set "ICONS_TARGET=%ProgramData%\IrfanView_FileIconOverrides"

:: Verify the Icons folder exists
if not exist "%ICONS_SOURCE%" (
	echo The 'Icons' folder is missing. Create one containing .ico files then re-run the script.
	pause
	exit /b
)

:: Verify at least one .ico file exists in the Icons folder
dir "%ICONS_SOURCE%\*.ico" >nul 2>&1
if errorlevel 1 (
    echo No '.ico' files found in the 'Icons' folder. Add at least one to the folder then re-run the script.
    pause
    exit /b
)

:: Create icon directory in ProgramData if it doesn't exist
if not exist "%ICONS_TARGET%" (
	mkdir "%ICONS_TARGET%"
	echo Created directory:	%ICONS_TARGET%
)

:: Copy icons to ProgramData
xcopy /y /q "%ICONS_SOURCE%\*.ico" "%ICONS_TARGET%"
if errorlevel 1 (
	echo Failed to copy icons. Check user permissions and/or access to file paths.
	pause
	exit /b
)

:: Register filetype icons
echo Updating registry...

:: Register new and existing icons
for %%i in ("%ICONS_SOURCE%\*.ico") do (
	reg query "HKCR\IrfanView.%%~ni" >nul 2>&1
	if errorlevel 1 (
		:: override extension default for previously default icons
		reg add "HKCR\.%%~ni" /ve /d "IrfanView.%%~ni" /f > nul

		:: copy irfanview key and shell\open\command subkeys, same for every type
		reg copy "HKCR\IrfanView" "HKCR\IrfanView.%%~ni" /s /f > nul
		
		echo ::  Successfully reated new file type association for [[ %%~ni ]]
	)
	
	:: [[ personal ]] remove IrfanView prefix from explorer extension name
	call :setname "%%~ni"
	
	:: override pointer from old icon to new icon
	reg add "HKCR\IrfanView.%%~ni\DefaultIcon" /ve /d "%ICONS_TARGET%\%%~nxi,0" /f > nul
	echo ::  Successfully set new file type icon for [[ %%~ni ]]
)

:: Refresh the icon cache
echo Restarting explorer for effect
taskkill /im explorer.exe /f >nul
start explorer.exe

echo IrfanView file icons overridden successfully!
pause
exit /b

:setname
:: Set the Explorer type name to e.g. "JPG File" (extension in upper case)
set "EXT_UP=%~1"
for %%L in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call set "EXT_UP=%%EXT_UP:%%L=%%L%%"
reg add "HKCR\IrfanView.%~1" /ve /d "%EXT_UP% File" /f > nul
exit /b
