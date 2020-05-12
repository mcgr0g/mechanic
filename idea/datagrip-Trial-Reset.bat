rem https://stackoverflow.com/a/57236125

cd "C:%HOMEPATH%\.DataGrip*\config"
rmdir "eval" /s /q
del "options\other.xml"
reg delete "HKEY_CURRENT_USER\Software\JavaSoft\Prefs\jetbrains\datagrip" /f
rem reg delete "HKEY_CURRENT_USER\Software\JavaSoft\Prefs" /v "/Jet/Brains./User/Id/On/Machine" /f
