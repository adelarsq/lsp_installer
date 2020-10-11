#!/usr/bin/env zsh

# Get file from:
# https://github.com/omnisharp/omnisharp-roslyn/releases/latest

case "$OSTYPE" in
    linux*)
        cd ~/Downloads
        rm -rf omnisharp-linux-x64.tar.gz
        wget https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.35.3/omnisharp-linux-x64.tar.gz
        mkdir omnisharp
        mv omnisharp-linux-x64.tar.gz omnisharp
        cd omnisharp
        tar zxpvf omnisharp-linux-x64.tar.gz
        rm -rf omnisharp-linux-x64.tar.gz
        rm -rf ~/dev/omnisharp
        mv run omnisharp_lsp_run
        chmod +x omnisharp_lsp_run
        cd ..
        mv omnisharp ~/dev
    ;;
    darwin*)
        cd ~/Downloads
        rm -rf omnisharp-osx.tar.gz
        curl -L -# -O 'https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.35.3/omnisharp-osx.tar.gz'
        mkdir omnisharp
        mv omnisharp-osx.tar.gz omnisharp/
        cd omnisharp
        tar zxpvf omnisharp-osx.tar.gz
        rm -rf omnisharp-osx.tar.gz
        rm -rf ~/dev/omnisharp
        mv run omnisharp_lsp_run
        chmod +x omnisharp_lsp_run
        cd ..
        mv omnisharp ~/dev
    ;;
esac

