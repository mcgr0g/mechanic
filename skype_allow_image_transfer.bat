@echo off
rem    This batch file enables file tranasfer
reg delete HKEY_CURRENT_USER\SOFTWARE\Policies\Skype\Phone /v DisableFileTransfer /f
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Skype\Phone /v DisableFileTransfer /f
ECHO fuck yeah
PAUSE
GOTO FINISH
