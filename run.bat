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

:: Create or clean the icon directory in ProgramData
if exist "%ICON_DIR%" (
    echo Cleaning up existing icons...
    attrib -R -H -S "%ICON_DIR%\*.ico"
    del /q "%ICON_DIR%\*.ico"
) else (
    echo Creating icon directory...
    mkdir "%ICON_DIR%"
    if errorlevel 1 (
        echo Failed to create directory: %ICON_DIR%. Check permissions.
        pause
        exit /b
    )
)

:: Copy icons to ProgramData
echo Copying icons...
xcopy /y /q /r "%ICONS_SOURCE%\*.ico" "%ICON_DIR%"
if errorlevel 1 (
    echo Failed to copy icons. Check if files are locked or permissions are adequate.
    pause
    exit /b
)

:: Update registry entries for IrfanView
echo Updating registry...
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
