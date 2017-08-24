#!/bin/bash
sudo pacman -Rsc firefox hexchat || \
sudo pacman -Syu && \
sudo pacman -S git terminator vlc aria2 chromium bleachbit vim transmission \
lldb valgrind zsh

#Git configuration
git config --global user.name "cjacquem"
git config --global user.email "cjacquem@student.42.fr"
if [ -f "~/.ssh/id_rsa" ]; then
    ssh-keygen -t rsa -b 4096 -C "cjacquem@student.42.fr"
    eval "$ssh-agent -s)" && ssh-dd ~/.ssh/id_rsa
fi
echo 'Need to add your ssh key in git services.'
read -p "It\'s ok ? y or n " answer
if [ $answer == 'n']; then
    exit 1
fi

#Creation du dossier projects
if [ ! -d "~/Documents/projects" ]; then
	mkdir ~/Documents/projects
	cd ~/Documents/projects
fi
#Creation du dossier 42
if [ ! -d "~/Documents/projects/42" ]; then
	mkdir ~/Documents/projects/42 && cd ~/Documents/projects/42
        git clone git@github.com:kalak-io/libft.git
        git clone git@github.com:kalak-io/ft_printf.git
fi
#Creation du dossier personal
if [ ! -d "~/Documents/projects/personal" ]; then
	mkdir ~/Documents/projects/personal
        cd ~/Documents/projects/personal
        git clone git@github.com:kalak-io/configuration.git
        git clone git@github.com:kalak-io/menu_generator.git
        git clone git@gitlab.com:kalak/pepper_dialog_generator.git
        git clone git@gitlab.com:kalak/pepper_conjugation_generator.git
        git clone git@gitlab.com:kalak/pepper_complete_lexicon.git
fi

#Configuration Vim
rm -rf ~/.vimrc ~/.vim
ln -s ~/Documents/projects/personal/configuration/vimrc ~/.vimrc
mkdir ~/.vim && mkdir ~/.vim/bundle
git https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
vim +PluginInstall +qall

#Configuration gitignore_global
ln -s ~/Documents/projects/personal/configuration/gitignore_global \
~/.gitignore_global && git config --global core.excludesfile ~/.gitignore_global


#Creation du dossier professional
if [ ! -d "~/Documents/projects/professional" ]; then
	mkdir ~/Documents/projects/professionnal
        cd ~/Documents/projects/professionnal

fi
cd
#Configuration zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s ~/Documents/projects/personal/configuration/zshrc ~/.zshrc
