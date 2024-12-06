#!/usr/bin/zsh
# Script de instalação - ZSH Tools + Plugins

# Verificação do diretório inicial
if cd; then
   echo -e "\e[33mIniciando script\e[0m"
else
   echo -e "\e[31mFalha ao iniciar o script: Não foi possível acessar o diretório inicial\e[0m"
   exit 1
fi

# Instalação do Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
   echo -e "\e[33mIniciando instalação do Oh-my-zsh...\e[0m"
   yes | bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
   echo -e "\e[32mOh-my-zsh já está instalado\e[0m"
fi

# Echo all the commands above to .zshrc
if ! grep -q "alias vim='nvim'" ~/.zshrc; then
   echo "alias vim='nvim'" >>~/.zshrc
else
   echo -e "\e[32mAlias vim já adicionado ao arquivo ~/.zshrc\e[0m"
fi

if ! grep -q "alias ls='ls -lh --color=auto'" ~/.zshrc; then
   echo "alias ls='ls -lh --color=auto'" >>~/.zshrc
else
   echo -e "\e[32mAlias ls já adicionado ao arquivo ~/.zshrc\e[0m"
fi

if ! grep -q "alias a='php artisan'" ~/.zshrc; then
   echo "alias a='php artisan'" >>~/.zshrc
else
   echo -e "\e[32mAlias a já adicionado ao arquivo ~/.zshrc\e[0m"
fi


# # Download do tema spaceship
# if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
#    echo -e "\e[33mIniciando download do tema spaceship...\e[0m"
#    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# else
#    echo -e "\e[32mTema spaceship já está baixado\e[0m"
# fi


# Instalação do Zinit com plugins
if [ ! -d "$HOME/.zinit" ]; then
   echo -e "\e[33mIniciando instalação do Zinit com plugins...\e[0m"
   bash -c "$(curl -fsSL https://git.io/zinit-install)"
else
   echo -e "\e[32mZinit já está instalado\e[0m"
fi

# Adição dos plugins ao arquivo ~/.zshrc se eles ainda não estiverem presentes.
if ! grep -q "Plugins for zdharma-continuum zinit" ~/.zshrc; then
   echo "### Plugins for zdharma-continuum zinit
    zinit for \
    light-mode zdharma-continuum/fast-syntax-highlighting \
    light-mode zdharma-continuum/history-search-multi-word \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions
    ### End of Zinit's plugins" >>~/.zshrc
else
   echo -e "\e[32mPlugins já adicionados ao arquivo ~/.zshrc\e[0m"
fi

# Configuração do lançamento do Zsh no arquivo ~/.bashrc se ainda não estiver configurado.
if ! grep -q "Launch Zsh" ~/.bashrc; then
   echo "# Launch Zsh
    if [ -t 1 ]; then
        exec zsh
    fi" >>~/.bashrc
else
   echo -e "\e[32mLançamento do Zsh já configurado no arquivo ~/.bashrc\e[0m"
fi

exec zsh