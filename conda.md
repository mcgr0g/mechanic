# conda howto on win7
use cmd or cmder (ConEmu)

## cmd
use [command](http://stackoverflow.com/a/60907)
`%windir%\system32\cmd.exe "/K" "C:\Users\%username%\Anaconda3\Scripts\activate.bat" "C:\Users\%username%\Anaconda3"`

## ConEmu
save it as new [task](http://conemu.github.io/en/NewConsole.html)

`-new_console:a:t:"conda" cmd.exe "/K" "%ConEmuBaseDir%\CmdInit.cmd" && "C:\Users\%username%\Anaconda3\Scripts\activate.bat" "C:\Users\%username%\Anaconda3\"`

## bash
todo

## first run

`conda info` - get version

`conda update anaconda` - update environment

`conda update --all` - update packages

`conda search numpy`
`conda search SciPy`

# config conda
`conda config --add channels conda-forge` -- добавляем канал [conda-forge](https://conda-forge.github.io/)

# web console kernel

`jupyter -h` - Show help information, including available subcommands.

`jupyter --config-dir` - There you can find your {application} cofigs when run `jupyter {application} --generate-config`

`jupyter --paths` - All dirs in one commands

`jupyter --paths --json` -- json like output

## config jupyter
read about [console](https://jupyter-console.readthedocs.io/en/latest/)

`conda install -c conda-forge jupyter-console` - install console

`jupyter console -h` -  configuration options

`jupyter kernelspec list` - list of available kernels

`jupyter console --generate-config` - make config file


## start jupyter

`jupyter notebook --generate-config` - make config for app notebook1

`jupyter notebook --help` - get options and utilites

`jupyter notebook` - start it
