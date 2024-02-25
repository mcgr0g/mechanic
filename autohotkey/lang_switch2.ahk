; AutoHotkey 2 Script

SendMode("Input") ; Sets the sending method to the "Input" mode.
SetWorkingDir A_ScriptDir ; Ensures a consistent starting directory.
SetCapsLockState "AlwaysOff"

TraySetIcon("lang_switch2.ico")

+CapsLock::CapsLock
CapsLock::Send("{Alt Down}{Shift Down}{Shift Up}{Alt Up}")
Return