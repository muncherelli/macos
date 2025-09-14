# macOS Automated Installer

my automated installer for configuring macOS with settings and applications to speed up installing and conguring macos

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/muncherelli/macos
   cd macos
   ```

2. **Customize your setup**
   - Edit `playbook.yml` to configure your applications and packages
   - Edit `os.sh` to customize macOS system settings

3. **Run the installer**
   ```bash
   ./init.sh
   ./update.sh
   ```

## Requirements

- macOS with Terminal.app having Full Disk Access
- Ansible (installed automatically by `init.sh`)

## Files

- `init.sh` - Initial setup and Ansible installation
- `update.sh` - Main installer script with full disk access check
- `playbook.yml` - Ansible playbook for applications and packages
- `os.sh` - macOS system configuration and preferences
- `requirements.yml` - Ansible role dependencies
