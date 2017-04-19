@echo off

call node %~dp0.lib/index.js create

:: change directory or exit
pushd .tmp || goto :END

:: get folder name using node script
for /f "delims=" %%i in ('node %~dp0.lib/index.js get-folder') do set input=%%i

pushd %input% || goto :END

call npm install
:: compile less files
call grunt less

popd

:: build script
if "%1" == "--skip" goto :DONE
call %~dp0.lib/gradlew.bat build
call %~dp0.lib/gradlew.bat --stop

popd

call node %~dp0.lib/index.js delete

:END
pause

:DONE
