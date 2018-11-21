#!/bin/bash

#Git configuration
read -rp 'Do you want configure your git repositories ? Y or N ' answer
if [ "$answer" = 'Y' ] || [ "$answer" = 'y' ]; then
    git config --global user.name "cjacquem"
    git config --global user.email "cjacquem@student.42.fr"
    if [ -e "$HOME/.ssh/id_rsa" ]; then
        ssh-keygen -t rsa -b 4096 -C "cjacquem@student.42.fr"
        eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
    fi
    read -rp 'Did you add your ssh keys in git services ? Y or N ' answer
    if [ "$answer" = 'N' ] || [ "$answer" = 'n' ]; then
        exit 1
    fi

    echo "Create projects directory"
    mkdir -p ~/Documents
    mkdir -p ~/Documents/projects
    mkdir -p ~/Documents/projects/42
    mkdir -p ~/Documents/projects/personal
    mkdir -p ~/Documents/projects/profesionnal

    cd ~/Documents/projects/42 || return
    echo "Clone 42 projects"
    if [ ! -d "./libft/" ]; then
        git clone git@github.com:kalak-io/libft.git
    fi
    if [ ! -d "./ft_printf/" ]; then
        git clone --recursive -j8 git@github.com:kalak-io/ft_printf.git
    fi
    if [ ! -d "./computor_v1/" ]; then
        git clone git@github.com:kalak-io/computor_v1.git
    fi
    if [ ! -d "./docker-1/" ]; then
        git clone git@github.com:kalak-io/docker-1.git
    fi
    if [ ! -d "./expert_system/" ]; then
        git clone git@github.com:kalak-io/expert-system.git expert_system
    fi
    if [ ! -d "./ft_linear_regression/" ]; then
	git clone git@github.com:kalak-io/ft_linear_regression.git
    fi
    if [ ! -d "./DSLR/" ]; then
        git clone git@github.com:kalak-io/DSLR.git
    fi
    if [ ! -d "./ft_apy/" ]; then
        git clone git@gitlab.com:kalak/ft_apy.git
    fi

    # MATRICE REPOSITORIES
    mkdir -p ~/Documents/projects/42/matrice
    cd ~/Documents/projects/42/matrice || return
    if [ ! -d "./scraper" ]; then
	git clone git@gitlab.com:matrice-monaco/scraper.git
    fi
    if [ ! -d "./call_api" ]; then
	git clone git@gitlab.com:matrice-monaco/call_api.git
    fi

    # PERSONAL REPOSITORIES
    cd ~/Documents/projects/personal || return
    echo "Clone personal projects"
    if [ ! -d "./configuration/" ]; then
        git clone git@github.com:kalak-io/configuration.git
    fi
    if [ ! -d "./archives_extractor/" ]; then
        git clone git@github.com:kalak-io/archives_extractor.git
    fi
    if [ ! -d "./menu_generator/" ]; then
        git clone git@github.com:kalak-io/menu_generator.git
    fi
    if [ ! -d "./restore_config" ]; then
        git clone git@github.com:kalak-io/restore_config.git
    fi
    if [ ! -d "./reduce_pdf_size" ]; then
        git clone git@github.com:kalak-io/reduce_pdf_size.git
    fi
    if [ ! -d "./personal_twitter_bot" ]; then
        git clone git@gitlab.com:kalak/personal_twitter_bot.git
    fi

    # PROFESIONNAL REPOSITORIES
    cd ~/Documents/projects/profesionnal || return
    echo "Clone profesionnal projects"
    if [ ! -d "./scrapy_bosch/" ]; then
	git clone git@gitlab.com:kalak/scrapy_bosch.git
    fi

    #Configuration gitignore_global
    rm ~/.gitignore_global
    ln -s ~/Documents/projects/personal/configuration/gitignore_global \
        ~/.gitignore_global && git config --global core.excludesfile ~/.gitignore_global
fi