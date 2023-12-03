# My (c)restic configurations and scripts

This is a work in progress. Documentation is lacking, scripts are not perfect and some important steps are not documented at all. Use with caution.

# Setup
1. Install [restic](https://github.com/restic/restic) and [crestic](https://github.com/nils-werner/crestic) (you might need to add crestic to PATH)
2. Clone this repository to `~/.config` (`${XDG_CONFIG_HOME:-~/.config}`)
3. run `install.sh` available in `linux` directory
4. You **need to** add your own `password` file and optionally `apprise.yaml`

# TODO:
- [ ] add paths to config to `.zshrc` and similar
- [ ] see `backup.ps1` and Task Scheduler XML files

# Projects used
- [nils-werner/crestic](https://github.com/nils-werner/crestic)
- [restic/restic](https://github.com/restic/restic)
- [caronc/apprise](https://github.com/caronc/apprise)
