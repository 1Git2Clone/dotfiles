# IN ORDER TO SCHEDULE THE PACKAGES-USED FOLDER
# YOU NEED TO SET UP THESE 2 CONFIG FILES FOR YOUR INIT SYSTEM

## For systemd:

`# /etc/systemd/system/update-package-list.service `

`[Unit]`
`Description=Update package list on startup`

`[Service]`
`Type=oneshot`
`ExecStart=/usr/bin/pacman -Qqe > ~/.config/package-list.txt`

`[Install]`
`WantedBy=default.target `


---

`# /etc/systemd/system/update-package-list.timer`

`[Unit]`
`Description=Run update-package-list.service daily`

`[Timer]`
`OnCalendar=daily`
`Persistent=true`

`[Install]`
`WantedBy=timers.target`

### Then you just need to run

`sudo systemctl enable update-package-list.timer`
`sudo systemctl start update-package-list.timer`
