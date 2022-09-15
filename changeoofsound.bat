@echo off
set OOF=%cd%\ouch.ogg
cd %UserProfile%\AppData\Local\Roblox\Versions
for /f %%i in ('dir /b/a:d/od/t:c') do set VERSION=%%i
del %VERSION%\content\sounds\ouch.ogg
copy %OOF% %VERSION%\content\sounds
echo Completed.
pause