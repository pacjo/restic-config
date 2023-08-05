# My (c)restic configurations and scripts

This is a work in progress. Documentation is lacking, scripts are not perfect and some important steps are not documented at all. Use with caution.

# Setup
1. Install [restic](https://github.com/restic/restic) and [crestic](https://github.com/nils-werner/crestic) (you might need to add crestic to PATH)
2. Clone this repository to `~/.config` (`${XDG_CONFIG_HOME:-~/.config}`)
3. **write the rest**

roughly commands:
1. `restic init --repo <path to repo>`
2. `git clone https://github.com/pacjo/restic-config ${XDG_CONFIG_HOME:-~/.config}/crestic`
3. `cd ${XDG_CONFIG_HOME:-~/.config}/crestic`
4. `touch password`
5. `echo "<your repo password>" > password`
(adjust crestic.service and crestic.timer to your needs)
6. `cp crestic.service crestic.timer ~/.config/systemd/user` (if you get error run: `mkdir -p ~/.config/systemd/user`)

> TODO
> add paths to config to `.zshrc` and similar
> add repo initialization instructions

# Usage
## Manual backups
> TODO
> basicly: `crestic <preset> <commnd> <optional arguments>`

## Schedules
### Linux
> TODO
> see `backup.sh`, `crestic.service` and `crestic.timer`
> rewrite properly:

to enable systemd service run:
`--user` is needed for access to user session (for notifications)
```
(1. `sudo cp crestic.service crestic.timer /etc/systemd/system/`) old, used for systemd service
1. `cp crestic.service crestic.timer ~/.config/systemd/user`
2. `systemctl --user enable crestic.timer`
2. `systemctl --user start crestic.timer`
```

see status with:
`systemctl --user status crestic.timer` or `systemctl --user status crestic.service`
reload (user) systemd services:
`systemctl --user daemon-reload`

### Windows
Unmaintained

> TODO
> see `backup.ps1` and Task Scheduler XML files

# Projects used
- [nils-werner/crestic](https://github.com/nils-werner/crestic)
- [restic/restic](https://github.com/restic/restic)
