@echo off
@rem %stPath%   : Path to Sublime Text installation dir.
@rem %entryName%: Key name for the registry entry.
@rem %menuText% : Context menu text. Set your preferred menu text (e.g.: translate to your language).

@rem SET stPath=d:\portable\SublimeText\sublime_text.exe
SET stPath=%~dp0\sublime_text.exe

SET entryName=Sublime Text 3x64
SET menuText=Open with ST3

rem add it for all file types
@reg add "HKEY_CLASSES_ROOT\*\shell\%entryName%"         /t REG_SZ /v "" /d "%menuText%"   /f
@reg add "HKEY_CLASSES_ROOT\*\shell\%entryName%"         /t REG_EXPAND_SZ /v "Icon" /d "%stPath%,0" /f
@reg add "HKEY_CLASSES_ROOT\*\shell\%entryName%\command" /t REG_SZ /v "" /d "%stPath% \"%%1\"" /f

rem add it for folders
@reg add "HKEY_CLASSES_ROOT\Folder\shell\%entryName%"         /t REG_SZ /v "" /d "%menuText%" /f
@reg add "HKEY_CLASSES_ROOT\Folder\shell\%entryName%"         /t REG_EXPAND_SZ /v "Icon" /d "%stPath%,0" /f
@reg add "HKEY_CLASSES_ROOT\Folder\shell\%entryName%\command" /t REG_SZ /v "" /d "%stPath% \"%%1\"" /f

pause
