@echo off
title Solving Network Shared Drive visibility Problem

call "%~dp0..\..\Assets\ImportReg.bat" "%~dp0..\..\Reg\Explorer\EnableNetworkSharedDrive.reg"


echo.

echo Network shared drives will be visible after restarting Windows.


echo.
pause