# dotfiles
This repo contains config files and playbook which will setup my fedora wsl environment

Steps
1. Make .dotfiles dir in user home directory
2. Intall ansible and git
3. Clone repo into .dotfiles (setup ssh keys before)
4. Run playbook

```
❯ cd
❯ pwd
/home/kavindu
❯ mkdir .dotfiles
❯ sudo git dnf install ansible -y
❯ git clone git@github.com:Kavindu-Rankothge/dotfiles.git /home/kavindu/.dotfiles/ 
❯ ansible-playbook bootstrap.yml

```

Playbook will install ohmyzsh, plugins and use stow
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

```
```
cd .dotfiles
stow .

stow --adopt .
```
