#!/usr/bin/env bash

INSTALL_GITHUB_REPO="hungify2022/czg-setup"
INSTALL_VERSION="v0.0.1"
HOME_DIR=~
# Reset
Color_Off=''

# Regular Colors
Red=''
Green=''
Dim='' # White

# Bold
Bold_White=''
Bold_Green=''

if [[ -t 1 ]]; then
  # Reset
  Color_Off='\033[0m' # Text Reset

  # Regular Colors
  Red='\033[0;31m'   # Red
  Green='\033[0;32m' # Green
  Dim='\033[0;2m'    # White

  # Bold
  Bold_Green='\033[1;32m' # Bold Green
  Bold_White='\033[1m'    # Bold White
fi

success() {
    echo -e "${Green}$@ ${Color_Off}"
}

error() {
    echo -e "${Red}error${Color_Off}:" "$@" >&2
    exit 1
}

info_bold() {
    echo -e "${Bold_White}$@ ${Color_Off}"
}

setup() {
	if [[ ${OS:-} = Windows_NT ]]; then
			echo 'Not support Windows OS'
			exit 1
	fi

	if ! command -v node &> /dev/null ; then
			error 'Node is not installed'
			exit 1
	fi

	if npm list -g czg | grep -q 'czg@'; then
			success 'czg is already installed'
	else
			npm install -g czg
			success 'czg is installed'
	fi


	CZRC_PATH="${HOME_DIR}/.czrc"

	if [ -f "$CZRC_PATH" ]; then
			read -p "The .czrc file already exists. Do you want to overwrite it? (y/n): " REPLY
			if [[ $REPLY =~ ^[Yy]$ ]]; then
					curl -sSL "https://raw.githubusercontent.com/${INSTALL_GITHUB_REPO}/${INSTALL_VERSION}/.czrc" > "$CZRC_PATH"
					success 'czg template has been written to ~/.czrc'
			else
					info_bold "The .czrc file was not overwritten."
			fi
	else
			curl -sSL "https://raw.githubusercontent.com/${INSTALL_GITHUB_REPO}/${INSTALL_VERSION}/.czrc" > "$CZRC_PATH"
			success 'czg template has been written to ~/.czrc'
	fi

}

setup
