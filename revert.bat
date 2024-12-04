@echo off
:: Set IrfanView default icon path
set "IRFANVIEW_ICON_PATH=C:\Program Files\IrfanView\i_view64.exe,0"

echo Reverting icons to IrfanView defaults...

:: Update registry for each file type
reg add "HKEY_CLASSES_ROOT\IrfanView.jpg\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.jpeg\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.jfif\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.gif\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.png\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f
reg add "HKEY_CLASSES_ROOT\IrfanView.webp\DefaultIcon" /ve /d "%IRFANVIEW_ICON_PATH%" /f

:: Refresh the icon cache
echo Refreshing icon cache...
taskkill /im explorer.exe /f >nul
start explorer.exe

echo Icons reverted to IrfanView defaults successfully!
pause
