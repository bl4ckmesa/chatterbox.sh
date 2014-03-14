#! /bin/bash

# File that has all the interesting person information
export f="/Users/family/.chatterbox"
[ -f $f ] && . $f

talk() {
	echo $@
	say $@ 2>/dev/null
}
yesno() {
	read yesno
	if [[ "$yesno" =~ (yes|y|Y|Yes) ]]; then
		return 0
	else
		return 1
	fi
}

introduction() {
	talk "Hi there.  What is your name?"
	read name
	talk "Hello $name, it is nice to meet you.  How old are you?"
	read age
	
	if [ $age -lt 10 ]; then
		talk "You seem a little young to be talking to a computer."
	else
		talk "You are such an old person."
	fi
	>$f
	echo "chNAME='$name'" >> $f
	echo "AGE='$age'" >> $f
	[ -f $f ] && . $f
}
playgame() {
	talk "Actually, I don't know any games.  Sorry!"
}

main() {
	if [ -n $chNAME ]; then
		talk "I think I know your name.  Is it $chNAME?"
		if yesno; then
			talk "I'm glad I got it right.  Shall we play a game?"
			if yesno; then
				playgame
			else
				talk "Well I guess I will talk to you later then.  Bye!"
				exit 0
			fi
		else
			talk "Oh, I'm sorry."
			introduction
			main
		fi	
	else
		introduction
		main
	fi
}

main $@
