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
	if [[ ! -f "$locUser" ]]
	then
		echo "no user registered yet"
	else
		if grep -q -w "$username $password" "$locUser"
		then
			echo "$calendar $time LOGIN:INFO User $username logged in" >> $locLog
			echo "Login success"

			printf "Enter command [dl or att]: "
			read command
			if [[ $command == att ]]
			then
				func_att
			elif [[ $command == dl ]]
			then
				func_dl_pic
			else
				echo "Not found"
			fi

		else
			fail="Failed login attemp on user $username"
			echo $fail

			echo "$calendar $time LOGIN:ERROR $fail" >> $locLog
		fi
	fi
}

func_dl_pic(){
	printf "Enter number: "
	read n

	if [[ ! -f "$folder.zip" ]]
	then
		mkdir $folder
		count=0
		func_start_dl
	else
		func_unzip
	fi

}

func_unzip(){
	unzip -P $password $folder.zip
	rm $folder.zip

	count=$(find $folder -type f | wc -l)
	func_start_dl
}

func_start_dl(){
	for(( i=$count+1; i<=$n+$count; i++ ))
	do
		wget https://loremflickr.com/320/240 -O $folder/PIC_$i.jpg
	done

	zip -P $password -r $folder.zip $folder/
	rm -rf $folder
}

func_att(){
	if [[ ! -f "$locLog" ]]
	then
		echo "Log not found"
	else
		awk -v user="$username" 'BEGIN {count=0} $5 == user || $9 == user {count++} END {print (count)}' $locLog
	fi
}


# main
calendar=$(date +%D)
time=$(date +%T)

printf "Enter your username: "
read username

printf "Enter your password: "
read -s password

# deff dir
folder=$(date +%Y-%m-%d)_$username
locLog=/home/wahid/sisop/modul1/log.txt
locUser=/home/wahid/sisop/modul1/users/user.txt

if [[ $(id -u) -ne 0 ]]
then
	echo "Please run as root"
	exit 1
else
	func_check_password
fi
