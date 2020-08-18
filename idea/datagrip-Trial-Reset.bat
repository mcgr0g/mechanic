rem https://stackoverflow.com/a/57236125

cd "C:%HOMEPATH%\.DataGrip*\config"
rmdir "eval" /s /q

cd "%LocalAppData%\JetBrains\DataGrip*"
rmdir "eval" /s /q

cd "%AppData%\JetBrains\DataGrip*"
rmdir "eval" /s /q

reg delete "HKEY_CURRENT_USER\Software\JavaSoft\Prefs\jetbrains\datagrip" /f
rem reg delete "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" /v "/Jet/Brains./User/Id/On/Machine" /f
