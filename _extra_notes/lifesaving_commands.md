# A list of very useful shell commands

I've made this list in case i forget about any of those commands and come in
the need to use them. You can tell I've made this list because I've been
through it.

## 1. Fix messed up permissions

This command is incredibly useful if you did something dumb like `chmod +x /`
and you want to fix your permissions.

```sh
find . -type f -perm /u=x,g=x,o=x -exec chmod -x {} \;
```

**NOTE:** If you actually did it in `/` then it's likely that you need to
exclude some directories before running the command. Ignore the following
directories when running the aforementioned command:

```sh
/bin/*
/usr/bin/*
/sbin/*
/usr/sbin/*
/lib/*
/lib64/*
/usr/lib/*
/usr/lib64/*
/etc/init.d/*
/etc/rc.d/*
/var/log/* # If you have custom scripts here.
```

My recommendation is to **NOT** run that find and `chmod` command in `/` all together
because you don't want to risk messing up your `/bin/` folder and the others.
It'll make your system unusable.
