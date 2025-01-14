@echo off
:: Set IrfanView default icon path
set "IRFANVIEW_ICON_PATH=C:\Program Files\IrfanView\i_view64.exe,0"

echo Reverting icons to IrfanView defaults...

:: Array of file extensions to update
set extensions=jpg jpeg jfif gif png webp

:: Iterate through each extension and update the registry
for %%E in (%extensions%) do (
    reg add "HKEY_CLASSES_ROOT\IrfanView.%%E\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f
    if errorlevel 1 (
        echo Failed to update registry for .%%E. Please check permissions or path validity.
        pause
        exit /b
    )
)

:: Refresh the icon cache
echo Refreshing icon cache...
taskkill /im explorer.exe /f >nul
start explorer.exe

echo Icons reverted to IrfanView defaults successfully!
pause
