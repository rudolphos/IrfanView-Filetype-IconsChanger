@echo off
:: Set variables
set "ICON_DIR=%ProgramData%\CustomIcons"
set "SCRIPT_DIR=%~dp0"
set "ICONS_SOURCE=%SCRIPT_DIR%Icon"

:: Verify the Icons folder exists
if not exist "%ICONS_SOURCE%" (
    echo The 'Icons' folder is missing. Place the folder in the same directory as this script.
    pause
    exit /b
)

:: Verify at least one .ico file exists in the Icons folder
dir "%ICONS_SOURCE%\*.ico" >nul 2>&1
if errorlevel 1 (
    echo No .ico files found in the 'Icons' folder. Ensure it contains valid .ico files.
    pause
    exit /b
)

:: Create icon directory in ProgramData if it doesn't exist
if not exist "%ICON_DIR%" (
    mkdir "%ICON_DIR%"
    echo Created directory: %ICON_DIR%
)

:: Copy icons to ProgramData
xcopy /y /q "%ICONS_SOURCE%\*.ico" "%ICON_DIR%"
if errorlevel 1 (
    echo Failed to copy icons. Please check permissions and file paths.
    pause
    exit /b
)

:: Register filetype icons
echo Updating registry...

:: Register .jpeg and .jpg with the custom icons
reg add "HKEY_CLASSES_ROOT\IrfanView.jpg\DefaultIcon" /ve /d "%ICON_DIR%\jpg.ico,0" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.jpeg\DefaultIcon" /ve /d "%ICON_DIR%\jpg.ico,0" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.gif\DefaultIcon" /ve /d "%ICON_DIR%\gif.ico,0" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.png\DefaultIcon" /ve /d "%ICON_DIR%\png.ico,0" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.webp\DefaultIcon" /ve /d "%ICON_DIR%\webp.ico,0" /f

:: Refresh the icon cache
echo Refreshing icon cache...
taskkill /im explorer.exe /f >nul
start explorer.exe

echo Icons updated successfully!
pause
