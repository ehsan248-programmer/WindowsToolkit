@echo off
reg import "%~1" >nul 2>&1
exit /b %errorlevel%