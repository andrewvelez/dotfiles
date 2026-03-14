### Concerning profile file loading order.

*File loading order specified here is from man bash.*

1. Booting into the system with a text login (tty) is an interactive login shell.
  And also, booting into KDE is unclear but appears to be a non-interactive shell with the --login option.

```bash
/etc/profile, ~/.bash_profile, ~/.bash_login, ~/.profile
```

2. Opening a terminal is an interactice non-login shell.

```bash
/etc/bash.bashrc, ~/.bashrc
```

3. A shell script running or a SysVInit style init script running or basically any program that is a shell script is a non-interactive non-login shell.

```bash
${BASH_ENV}
```
