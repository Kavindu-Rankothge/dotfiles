# dotfiles
This repo contains config files and playbook which will setup my fedora wsl environment

Steps
1. Make .dotfiles dir in user home directory
2. Clone repo into .dotfiles (setup ssh keys before)
3. Install ansible
4. Run playbook
5. Setup other stuff

```
❯ cd
❯ pwd
/home/kavindu
❯ mkdir .dotfiles
❯ cd .dotfiles
❯ git clone git@github.com:Kavindu-Rankothge/dotfiles.git
❯ sudo dnf install ansible -y
❯ ansible-playbook bootstrap.yml

```
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

```
cd .dotfiles
stow .

stow --adopt .
```
