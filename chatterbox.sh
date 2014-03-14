#! /bin/bash

SOURCEDIR="/Users/family/svn/chatterbox.sh"

# Source in env
[ -f "$SOURCEDIR/lib/env" ] && . "$SOURCEDIR/lib/env"

# Source in library
LIB="$SOURCEDIR/lib"
[ -d $LIB ] && for lib in $LIB/*; do . $lib; done

# File that tracks the last person to chat with the chatterbox
export f="/Users/family/.chatterbox"
[ -f $f ] && . $f

introduction() {
	chatter "Hi there.  What is your name?"
	read name
	chatter "Hello $name, it is nice to meet you.  How old are you?"
	read age
	
	if [ $age -lt 10 ]; then
		chatter "You seem a little young to be talking to a computer."
	else
		chatter "You are such an old person."
	fi
	>$f
	echo "chNAME='$name'" >> $f
	echo "AGE='$age'" >> $f
	[ -f $f ] && . $f
}
playgame() {
	chatter "Actually, I don't know any games yet.  Sorry!"
}

set -e 
main() {
	if [ -n "$chNAME" ]; then
		chatter "I think I know your name.  Is it $chNAME?"
		if yesno; then
			chatter "I'm glad I got it right.  Shall we play a game?"
			if yesno; then
				playgame
			else
				chatter "Well I guess I will talk to you later then.  Bye!"
				exit 0
			fi
		else
			chatter "Oh, I'm sorry."
			introduction
			main
		fi	
	else
		introduction
		main
	fi
	exit 0
}

main $@
