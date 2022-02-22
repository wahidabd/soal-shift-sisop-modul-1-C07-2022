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
	local locUser=/home/wahid/sisop/modul1/users/user.txt
	local locLog=/home/wahid/sisop/modul1/log.txt

	if grep -q $password "$locUser"
	then
		echo "$calendar $time LOGIN:INFO User $username logged in" >> $locLog
	else
		fail="Failed login attemp on user $username"
		echo $fail

		echo "$calendar $time LOGIN:ERROR $fail" >> $locLog
	fi

}

func_

calendar=$(date +%D)
time=$(date +%T)

printf "Enter your username: "
read username

printf "Enter your password: "
read -s password

func_check_password
