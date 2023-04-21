@echo off
set UNLOCKER=%cd%\ClientAppSettings.json
cd %UserProfile%\AppData\Local\Roblox\Versions
for /f %%i in ('dir /b/a:d/od/t:c') do set VERSION=%%i
RD /S /Q %VERSION%\ClientSettings
MD %VERSION%\ClientSettings
copy %UNLOCKER% %VERSION%\ClientSettings
echo Completed.
pause