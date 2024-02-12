#!/usr/bin/env bash

install_brew_formula() {
	local formula=$1
	if brew list --formula | grep "$formula" >/dev/null; then
		echo "$formula is already installed"
	else
		echo "Installing $formula"
		brew install $formula
	fi
}

install_xcode() {
	if xcode-select -p >/dev/null; then
		echo "xcode Command Line Tools already installed"
	else
		echo "Installing xCode Command Line Tools..."
		xcode-select --install
		sudo xcodebuild -license accept
	fi
}

install_homebrew() {
	if hash brew &>/dev/null; then
		echo "Homebrew already installed"
	else
		echo "Installing homebrew..."
		sudo --validate # reset `sudo` timeout to use Homebrew install in noninteractive mode
		NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
}

install_git() {
	if [ $(uname) == "Darwin" ]; then
		install_brew_formula git
	elif command -v git >/dev/null; then
		echo "git is already installed"
	elif command -v apt >/dev/null; then
		sudo apt install -y git
	elif command -v pacman >/dev/null; then
		sudo pacman -Sy git
	elif command -v dnf >/dev/null; then
		sudo dnf install git
	fi
}

install_ansible() {
	if [ $(uname) == "Darwin" ]; then
		install_brew_formula ansible
	elif command -v ansible >/dev/null; then
		echo "ansible is already installed"
	elif command -v apt >/dev/null; then
		sudo apt install software-properties-common
		sudo add-apt-repository --yes --update ppa:ansible/ansible
		sudo apt install -y ansible
	elif command -v pacman >/dev/null; then
		sudo pacman -Sy ansible
	elif command -v dnf >/dev/null; then
		sudo dnf install ansible
	fi
}

install_stow() {
	if [ $(uname) == "Darwin" ]; then
		install_brew_formula stow
	elif command -v stow >/dev/null; then
		echo "stow is already installed"
	elif command -v apt >/dev/null; then
		sudo apt install -y stow
	elif command -v pacman >/dev/null; then
		sudo pacman -Sy stow
	elif command -v dnf >/dev/null; then
		sudo dnf install stow
	fi
}

if [ $(uname) == "Darwin" ]; then
	install_xcode
	install_homebrew
fi
install_git
install_ansible
install_stow
