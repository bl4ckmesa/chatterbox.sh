#! /bin/bash
#
# ### Custom Commands (commands I wrote for this script.  They live in lib/functions.)
#   getinput - get user input into given variable (e.g., `getinput name` gives you a name variable)
#    chatter - print text out to terminal while also saying it out loud (e.g., `chatter "Hello"`)
#        say - Get input of yes or no.  Used with 'if' (e.g., `if yes; then chatter "Hello"; fi`)

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
		chatter "There is no way you are as old as that!  Amazing!"
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
		if yes; then
			chatter "I'm glad I got it right.  Shall we play a game?"
			while yes; do
				playgame
				chatter "Do you want to keep playing games?"
			done
			chatter "Well I guess I will talk to you later then.  Bye!"
			exit
		else
			chatter "Oh, I'm sorry."
			introduction
			main
		fi	
	else
		introduction
		main
	fi
	exit
}

main $@
