#! /bin/bash
# Source in the environments
SDIR="/Users/family/svn/chatterbox.sh" && . "$SDIR/lib/functions" && setenv || exit 254
set -e 

introduction() {
	chatter "Hi there.  What is your name?"
	getinput name
	chatter "Hello $name, it is nice to meet you.  How old are you?"
	getinput age int
	
	if [ $age -lt 10 ]; then
		chatter "You seem a little young to be talking to a computer."
	elif [ $age -gt 1000 ]; then
		chatter "There is no way you are that old!  Amazing!"
	else
		chatter "You are such an old person."
	fi
	>$f
	echo "chNAME='$name'" >> $f
	echo "AGE='$age'" >> $f
	[ -f $f ] && . $f
}

main() {
	if [ -n "$chNAME" ]; then
		chatter "I think I know your name.  Is it $chNAME?"
		if yesno; then
			chatter "I'm glad I got it right.  Shall we play a game?"
			while yesno; do
				playgame
				chatter "Do you want to keep playing games?"
			done
			chatter "Well I guess I will talk to you later then.  Bye!"
			exit 0
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
