# git livehacks

For windows users

## CRLF error

if have such [gitconfig](https://github.com/mcgr0g/dotfiles/blob/master/.gitconfig#L18) and have error like `libgit2 returned: CRLF would be replaced by LF in 'filename'`
so you need another gitconfig or you can run "Git Bash Here" near problem file and run
`sed -i 's/\r$//' filename`