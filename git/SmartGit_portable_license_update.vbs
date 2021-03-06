' #### about #####################
' the trick is remove setting file
' http://stackoverflow.com/a/14228485/2643890
' #### about #####################

' init environment
set WshShell = CreateObject("WScript.Shell")
set fso = CreateObject("Scripting.FileSystemObject")
' init local parameters
strPath = Wscript.ScriptFullName
set objFile = fso.GetFile(strPath)
dirCurr = fso.GetParentFolderName(objFile) & "\"

appDataLocation = WshShell.ExpandEnvironmentStrings("%APPDATA%")
dirTarget = dirCurr & ".settings\" ' \SmartGit\.settings\

filePattern = "settings.xml"

versionCurr = 1 ' for saving version of SmartGit

wscript.echo "removing" & dirTarget

set targetFolder = fso.GetFolder(dirTarget)
set targerSubfolder = targetFolder.SubFolders

' searching for hiest version
For Each objFolfer in targerSubfolder 
    versionFound = objFolfer.Name
    If IsNumeric(versionFound) Then ' check it's float like 12,3
        If CLng(versionFound) Then ' check it's integer like 12
            If versionFound > versionCurr Then
                versionCurr = versionFound
            End If
        End If
    End If
Next

if versionCurr = 1 then Wscript.Quit 
fileTarget = dirTarget & versionCurr & "\" & filePattern

if fso.FileExists(fileTarget) then
    wscript.echo "removing" & vbTab & fileTarget
    fso.DeleteFile fileTarget
end if
