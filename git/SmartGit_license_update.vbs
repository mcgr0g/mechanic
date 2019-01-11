' #### about #####################
' the trick is remove setting file
' http://stackoverflow.com/a/14228485/2643890
' #### about #####################

' init environment
set WshShell = CreateObject("WScript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")
Set objRegExp = CreateObject("VBScript.RegExp")
' init local parameters
strPath = Wscript.ScriptFullName
set objFile = fso.GetFile(strPath)
dirCurr = fso.GetParentFolderName(objFile) & "\"

appDataLocation = WshShell.ExpandEnvironmentStrings("%APPDATA%")
dirTarget = appDataLocation & "\syntevo\SmartGit\" ' %APPDATA%\syntevo\SmartGit\

filePattern = "settings.xml"

versionCurr = 1 ' for saving version of SmartGit

set targetFolder = fso.GetFolder(dirTarget)
set targetSubfolder = targetFolder.SubFolders
' Wscript.Echo targetFolder

objRegExp.Pattern = "^[0-9]{2}.[0-9]$"

' searching for hiest version
For Each objFolder in targetSubfolder 
    versionFound = objFolder.Name
    ' WScript.Echo versionFound
    ' WScript.Echo TypeName(versionFound)
    ' WScript.Echo TypeName(Cstr(versionFound))
    If IsNumeric(versionFound) Then ' check it's float like 17.1
        ' Wscript.Echo versionFound
        If versionCurr = 1 then Wscript.Quit 
    End If
    If (objRegExp.Test(versionFound) = True) Then
        versionCurr = versionFound
        ' WScript.Echo versionCurr
        ' WScript.Echo TypeName(versionCurr)
        ' WScript.Echo CDbl(versionCurr)
        ' WScript.Echo CDbl(Replace(versionFound, ".", ","))
    End If
Next

fileTarget = dirTarget & versionCurr & "\" & filePattern

if fso.FileExists(fileTarget) then
    wscript.echo "removing" & vbTab & fileTarget
    fso.DeleteFile fileTarget
end if
