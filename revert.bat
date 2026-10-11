@echo off
:: Prompt UAC if script is not elevated
fltmc >nul 2>&1
if errorlevel 1 (
	if "%~1"=="elevated" (
		echo Could not obtain administrator rights. Right-click revert.bat and choose "Run as administrator".
		pause
		exit /b 1
	)
	powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -ArgumentList 'elevated' -Verb RunAs"
	exit /b
)

:: Set IrfanView default icon path
set "IRFANVIEW_ICON_PATH=C:\Program Files\IrfanView\i_view64.exe,0"
set "ICONS_SOURCE=%~dp0Icon"

if not exist "C:\Program Files\IrfanView\i_view64.exe" (
	echo IrfanView not found at C:\Program Files\IrfanView\i_view64.exe. Edit IRFANVIEW_ICON_PATH in this script.
	pause
	exit /b 1
)

echo Reverting icons to IrfanView defaults...

:: Revert every extension run.bat could have changed (one per .ico file) plus jfif
for %%E in (jfif) do call :revert %%E
for %%i in ("%ICONS_SOURCE%\*.ico") do call :revert %%~ni

:: Refresh the icon cache
echo Refreshing icon cache...
taskkill /im explorer.exe /f >nul
start explorer.exe

echo Icons reverted to IrfanView defaults successfully!
pause
exit /b

:revert
:: only touch associations that exist, don't create empty keys
reg query "HKCR\IrfanView.%1" >nul 2>&1
if errorlevel 1 exit /b
reg add "HKCR\IrfanView.%1\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f >nul
if errorlevel 1 (
	echo Failed to update registry for .%1. Please check permissions or path validity.
) else (
	echo ::  Reverted [[ %1 ]]
)
exit /b
