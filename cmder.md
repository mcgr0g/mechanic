# set win var

see https://github.com/cmderdev/cmder/wiki/Setting-up-Environment-Variables

i use user var
`CMDER_ROOT`= `%USERPROFILE%\opt\cmder`
`%ConEmuDir%` = `%CMDER_ROOT%\vendor\conemu-maximus5`

and in cmd:
```
cd %cmder_root%
Cmder.exe /REGISTER USER
```

optional:
https://github.com/cmderdev/cmder/wiki/Seamless-VS-Code-Integration

# integrate with ST3
i use user var for^
`ST3_ROOT`= `%USERPROFILE%\opt\ST3`
and append to `%cmder_root%\config\user_aliases.cmd`
```
alias subl="%ST3_ROOT%\sublime_text.exe" $*
```

# integrate with Idea
https://github.com/cmderdev/cmder/wiki/Seamless-IntelliJ-based-Integration