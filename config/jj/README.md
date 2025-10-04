# jj Configuration

jj automatically loads config files from `conf.d/` directory.

## Setup

1. Run `./install.sh` to symlink the config
2. Copy `conf.d/local.toml.example` to `conf.d/local.toml` and set your email:
   ```toml
   [user]
   email = "your-email@example.com"
   ```
