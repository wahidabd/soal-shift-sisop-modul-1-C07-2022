func_check_password(){
	local lengthPassword=${#password}

	if [[ $lengthPassword -lt 8 ]]
    	then
        	echo "Password must be more than 8 characters"

	elif [[ "$password" != *[[:upper:]]* || "$password" != *[[:lower:]]* || "$password" != *[0-9]* ]]
	then
       		echo "Password must be at least upper, lower and number!"

    	else
		func_login
	fi
}

func_login(){
	if grep -q $password "$locUser"
	then
		echo "$calendar $time LOGIN:INFO User $username logged in" >> $locLog
		echo "Login success"

		printf "Enter command [dl n or att]: "
		read command
		if [[ $command == att ]]
		then
			func_att
		fi

	else
		fail="Failed login attemp on user $username"
		echo $fail

		echo "$calendar $time LOGIN:ERROR $fail" >> $locLog
	fi

}

func_att(){
	awk '
	BEGIN {print "Count login attemps"}
	/LOGIN/ {++n}
	END {print "Login attemps:", n}' $locLog
}

locUser=/home/wahid/sisop/modul1/users/user.txt
locLog=/home/wahid/sisop/modul1/log.txt


calendar=$(date +%D)
time=$(date +%T)

printf "Enter your username: "
read username

printf "Enter your password: "
read -s password

func_check_password
