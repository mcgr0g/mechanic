; AutoHotkey Script
#SingleInstance ignore
Menu, Tray, Icon, %A_WorkingDir%\lang_switch.ico,,1

SetCapsLockState, AlwaysOff
+CapsLock::CapsLock

CapsLock::Send, {Alt down}{Shift down}{Alt up}{Shift up}
return