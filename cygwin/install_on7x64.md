описание установки ssh on cygwin
--------------------------------

следует помнить необходимые [пакеты](./requiremets.md)
ставить ли зависимости: да
далее процесс описания ssh дем

оболочка cygterm (от администратора):
-------------------------------------
Options -> Text -> Locale: ru_RU Character set: CP866

`ssh-host-config`

Query: Should StrictModes be used?
Answer: **yes**

Query: Should privilege separation be used?
Answer: **yes**

Query: Do you want to install sshd as a service?
Answer: **yes**

Query: Enter the value of CYGWIN for the daemon:
Answer: **ntsec**

Query: Do you want to use a different name?
Answer: **no**

Query: Create new privileged user account 'cyg_server'?
Answer: **yes**

Query: Please enter the password:
Answer: **hardpassword**

>запускаем службу

`net start sshd`

>настраиваем порт

`nano /etc/sshd_config`
>Port 2452
>Protocol 2
>PubkeyAuthentication yes
>AuthorizedKeysFile .ssh/authorized_keys

ctrl+o ; ctrl+x

```
net stop sshd
net start sshd
```
ctrl+d

оболочка cygterm (не от администратора):
----------------------------------------

>создаем свои ключи и запоминаем их
`ssh-user-config`

Query: Shall I create a SSH2 RSA identity file for you?              Answer: **yes**

Query: Do you want to use this identity to login to this machine?    Answer: **yes**

Query: Shall I create a SSH2 DSA identity file for you?              Answer: **yes**

Query: Shall I create a SSH2 ECDSA identity file for you?            Answer: **no**

Query: Shall I create a (deprecated) SSH1 RSA identity file for you? Answer: **no**


>копируем приватный ключ `c:\cygwin\home\%username%\.ssh\id_rsa`
> и проверяем работу sshd

`ssh –v localhost`
ctrl+d; ctrl+d

оболочка cmd (от администратора):
---------------------------------

>установим автозапуск службы
```
if not defined CYGWIN_HOME set CYGWIN_HOME=%SystemDrive%\cygwin
sc config sshd start= auto
```

>откроем порт 2452 на винде, что бы заходить в порт cygwin
```
netsh advfirewall firewall add rule name="SSH Server" dir=in protocol=TCP localport=2452 remoteport = 2452 action=allow
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow program="%CYGWIN_HOME%\usr\sbin\sshd.exe" enable=yes`
```

менеджер пакетов
----------------

на основе [apt-cyg](https://github.com/kou1okada/apt-cyg):
```
wget https://raw.githubusercontent.com/kou1okada/apt-cyg/master/apt-cyg
chmod +x apt-cyg # set executable bit
mv apt-cyg /usr/local/bin # move somewhere to PATH
apt-cyg scriptinfo
apt-cyg completion-install
apt-cyg show
```
