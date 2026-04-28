#!/bin/bash


clear

echo "Please type in your password. No letters will appear as you type."
echo "Press return when done."
sudo true # authorize for later

# Install Apple's final security update for High Sierra
sudo softwareupdate --install "Security Update 2020-005-10.13.6"
sleep 2
killall cfprefsd
sleep 2

# --- USEFULL STUFF FROM MAVERICKSFOREVER.COM PROJECT --- #
# Disable Automatic Termination

defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/.GlobalPreferences NSDisableAutomaticTermination -bool true


# Make Finder windows open to the home folder

defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.finder NewWindowTarget -string "PfLo"


# When performing a search, search the current folder by default

defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.finder FXDefaultSearchScope -string "SCcf"


# Do not save files to iCloud by default

defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/.GlobalPreferences NSDocumentSaveNewDocumentsToCloud -bool false


# Disable "Do you want to use this disk to back up with Time Machine?"

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


# Disable autocorrect

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/.GlobalPreferences NSAutomaticSpellingCorrectionEnabled -bool false
sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/.GlobalPreferences WebAutomaticSpellingCorrectionEnabled -bool false


# Disable "Smart Lists" and "Smart Links" in Notes app

defaults write com.apple.Notes ShouldUseSmartLinks -bool false
defaults write com.apple.Notes EnableAutomaticListInsertion -bool false

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.Notes ShouldUseSmartLinks -bool false
sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.Notes EnableAutomaticListInsertion -bool false


# Unhide Library folder

chflags nohidden ~/Library
mkdir -p ~/Library/LaunchAgents/
echo '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>Label</key><string>local.show-library</string><key>ProgramArguments</key><array><string>/bin/bash</string><string>-c</string><string>chflags nohidden ~/Library</string></array><key>RunAtLoad</key><true/></dict></plist>' | tee ~/Library/LaunchAgents/show-library.plist

sudo -p mkdir /System/Library/User\ Template/Non_localized/Library/LaunchAgents/
echo '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>Label</key><string>local.show-library</string><key>ProgramArguments</key><array><string>/bin/bash</string><string>-c</string><string>chflags nohidden ~/Library</string></array><key>RunAtLoad</key><true/></dict></plist>' | sudo tee /System/Library/User\ Template/Non_localized/Library/LaunchAgents/show-library.plist


# Unhide /usr

sudo chflags nohidden /usr


# Disable Gatekeeper

sudo spctl --master-disable


# Give /Applications/Utilities/ the same permissions as /Applications/

sudo chmod 775 /Applications/Utilities/

# --- Compatibility --- #
# Don't create .DS_Store files on network and USB drives. (They will continue to appear on local drives.)

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.desktopservices DSDontWriteNetworkStores -bool true
sudo defaults write /System/Library/User\ Template/Non_localized/Library/Preferences/com.apple.desktopservices DSDontWriteUSBStores -bool true


# Prevent media keys from launching iTunes.

if [ $(shasum /System/Library/CoreServices/rcd.app/Contents/MacOS/rcd | awk '$0=$1') = "fffb4d6ec495a1382364f73c6a0f45ca4f42c563" ]; then
	RCDPATCH=`mktemp -t rcd-patch`
	echo QlNESUZGNDBcAAAAAAAAAKUDAAAAAAAAQCUBAAAAAABCWmg5MUFZJlNZYDMG+AAAJv9D+FGCAABABAAAEEBAIABACAACQAAAAyAAIZNUyPQJibUKBpoZGTE4qJ7vbGHhqkkDl99EjLDUq6+7Qk1EhER+LuSKcKEgwGYN8EJaaDkxQVkmU1kWxGS8AAA8////3eLFYmBbiGzXbb5APARSwf////B2d//Cxn/9yudf78ADDNDLgl26iJqNEyjIeUNDTQAAAANAaNBoBoA0GnqNAaNAAAAAAeoyDag1DUpsoGQGgA0AaGmgAAAAAABkaAAADIAAAPUPUGgEiiTRMmUeoGTQGgDRppoANNDQaANAGmjTQA0aAAAAGmQAPQmgklEap6ntRPyk9I8ptT1GRoZPSZNAA0MIwgGRkZGEABoMgMTTTRk0YRkwCPwd9ZYipTAJcujCuaSYdXpf3T6/r3vHiYNdTNwGAMYOdyEopjwEJFiiji4FzAyg/PMLTl0MVywhma8oQ4USDaaLNgFkwItAfloSSIsQvXIgCiwSsGKGNr48ZmCyQcwt8IJnMOB4QDu16hJBQHRatY58ZJrma4loXO1dligFuBJJXzVVVWh6VMx37gCQBIkXmL9d7urGprq0noSVFgri2hx2aVovNrD+ZyCP8xXb1oxUXxGK6esZSYpjQGoYjQOe0hAF7escEECygTmpDpzBsjPd1WQEkkxsPvfQIqg1BoAptISQdti4M2AkLsdbC7UlRysWXuURxMk5SrOcPlNVogsvQNBsruBpc5wQi9t0lnhZ0SPw8hly4xvJmv4FCm3aL7+O0R4btNBMpSmpM3qQEMEFd13IlAO8HavsBA0CdhAAp54IIir7BYJ8Qjq2O9ExDPRGdK5mCQ4sKYi+qpb9UUH5yo1SlHYYB+cYjoGSUAg9b5I9+TA8KFB/SkQQIIqk4bL2nDITXBkiDQFJoDZMhM6SlA6QoUWfBwPq9GdfEElInSWTEM/EMiYINgEhzPYaWSUDA7NMwW1DDQMiMpu9njcV85CTzaaDSJQgiCpRZ6CQIjZpPqKMERjL2L5QQBMgKEcNsMOAZwMOMREGDoWJTGVzq6SEpcmVuJCdQTabN3fttYEybua2Owdr8p6CKy9xb1yCTX2YEUGhyWVyzhCQmuauBBBV/00v5gdZ430edL2XmPJRGZhqnqXunCA8kSpuUA6QAMAJeGbJFmohZhVkGDv0IJ5CDRoaGPYmAIyhzCPlaeiMAREAtoRbbbY22gz0mQiR2UCwlnWc9VjLVqoyDKX0/VGUFhPamU4shIBE2T8bFwcR8JAnxykjAYIDDmmrilK0HDFyoHfiTZsEhAGRu4HqqQkGYmHNigrMOBPatKUsVVDQQFjAAKpjBLPeI8P8XckU4UJAWxGS8EJaaDkxQVkmU1lvweEyAAAg/P/OGCgpYEQqEEIAJQqAoAkAAAgEwIACgAJAACAIIABBWoAAABk0YmjxQw0MmQMjEGJk0NMGgAlhBAAhwtXTYuZKRxSwm6jvwrlnYuI+3m0X/GZYKI2IAPxdyRThQkG/B4TI | base64 --decode > $RCDPATCH
	sudo mv /System/Library/CoreServices/rcd.app/Contents/MacOS/rcd /System/Library/CoreServices/rcd.app/Contents/MacOS/rcd-bk
	sudo bspatch /System/Library/CoreServices/rcd.app/Contents/MacOS/rcd-bk /System/Library/CoreServices/rcd.app/Contents/MacOS/rcd $RCDPATCH
	sudo chmod +x /System/Library/CoreServices/rcd.app/Contents/MacOS/rcd
fi

if [ $(shasum /System/Library/CoreServices/AVRCPAgent.app/Contents/MacOS/AVRCPAgent | awk '$0=$1') = "798f7271d1a499c879807fc9f9a2e774b5b62bba" ]; then
	AVRCPPATCH=`mktemp -t AVRCPAgent-patch`
	echo QlNESUZGNDBQAAAAAAAAAO0CAAAAAAAAUGkBAAAAAABCWmg5MUFZJlNZqSgABwAAGP5D+DCIAAEkQEAEAABAQAAEAAAAgEAgACGk0NNDQxCmTEyDIxcLlkCECHGMif3o67zDSY+LuSKcKEhUlAADgEJaaDkxQVkmU1mF9SE7AABb///Y3Pvu0//uXNNlH1T1TJxJV9LwwED+7+Mb+N+/6////8ACTgQG0GiJM1FGjTQ0DTTR6hkA0NAGgAaaBoPUPUyaDNT1HqaANPQT2VPKMnqNP1MoyeMKeppMhVIP3pNSgAAAAAAADQAAAAAAAAAAAAAAAADRBkwgyAaGIMmmjJgIwIyaZNDRiDEZMAmjQGjIGIaYTTI00aBkyZMACJSSgaNA0AEwGgAAaBMAABMAAAAAABBgAAAABpIAQIpDp6AFZLmNv/OdlRMSAZLy1XHN+u++SjS5X1VQq/yeqpo89Weg+3muPyvdfJWlVhbrC11X2z+ftwJ6pWgWMCjYR4cMbGtGRbGIUgGagqpSAA47EIAVLAV60SixCLIBIskiwiiQgjEQEgW+gqCGby1kWWUla0Z0zxCGfNAmgKEmhaVUpKpSkoSVqqFIUIylGjaVRGviCqSFnIJJREpFkGRYEWCkAgAUzNF4URD5kQkmCBXJggALCTbJ69Vbl3EKVvEQ3yBYGD2LxfuWdGUxEqMWXU0Et4WM21r3q6nd2mi/rP+k4GpDjBE9X4vEjP3EOP6vJYfi6xNMy01Scen+e9m6uPK+GR61XUbDnWMzY8i8/fixr+71m4pHaHmIQMIxwzHaABE0cIo3WRPcwUhRFtuLc9KtXJu+QHIaN1i2qbY5a4AbSHaa3R31PIYf1rSmaK+XQzk5ZsAo6J5pBiBFCsWd70IieYoweBV+eni0ElE+VJIZMljZeSK++dTN+iH4aAQOdsPKsLE7UyXBumjmxaixWWHNjU+AvZzKm0vcetYOKhGzRSMZsiWlcwZggbiBB4c5IhcbMazVKVIUpSlKUpRo9fpZYGZshrLfhmymZmZERERERERERGu+2aurq6utVqa/J+5GoavHtBFqD8IwRBK0Ccn9VIhchCOi+2pGr/mDQAAAAAAAAAAAAACAAAAAACUpQlKSYf4u5IpwoSEL6kJ2QlpoOTFBWSZTWVbXm+cAAAnBAMAAAIAACCAAIKU0GY1GwTxdyRThQkFbXm+c | base64 --decode > $AVRCPPATCH
	sudo mv /System/Library/CoreServices/AVRCPAgent.app/Contents/MacOS/AVRCPAgent /System/Library/CoreServices/AVRCPAgent.app/Contents/MacOS/AVRCPAgent-bk
	sudo bspatch /System/Library/CoreServices/AVRCPAgent.app/Contents/MacOS/AVRCPAgent-bk /System/Library/CoreServices/AVRCPAgent.app/Contents/MacOS/AVRCPAgent $AVRCPPATCH
	sudo chmod +x /System/Library/CoreServices/AVRCPAgent.app/Contents/MacOS/AVRCPAgent
fi


# Set bash autocompletion to ignore case

printf "set completion-ignore-case On" > ~/.inputrc

sudo bash -c 'printf "set completion-ignore-case On" > /System/Library/User\ Template/Non_localized/.inputrc'


# Shorten bash prompt to show only the current directory.

echo 'export PS1="\W$ "' > ~/.bash_profile

sudo bash -c 'echo "export PS1=\"\W$ \"" > /System/Library/User\ Template/Non_localized/.bash_profile'




# --- REMOVE NONFUNCTIONAL APPS AND FEATURES --- #


# Dashboard Widgets

sudo rm -rf /Library/Widgets/ESPN.wdgt
sudo rm -rf /Library/Widgets/Flight\ Tracker.wdgt
sudo rm -rf /Library/Widgets/Movies.wdgt
sudo rm -rf /Library/Widgets/Ski\ Report.wdgt
sudo rm -rf /Library/Widgets/Stocks.wdgt
sudo rm -rf /Library/Widgets/Translation.wdgt
sudo rm -rf /Library/Widgets/Unit\ Converter.wdgt
sudo rm -rf /Library/Widgets/Weather.wdgt
sudo rm -rf /Library/Widgets/Web\ Clip.wdgt/

# --- CLEANUP --- #


# Fix permissions in User Template folder

sudo chown -R root:wheel /System/Library/User\ Template/
sudo chmod 700 /System/Library/User\ Template/


killall Dock Finder rcd
clear
printf "\n\n\nAll done! You should restart your Mac.\n"
