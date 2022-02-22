func_check_password() {
  local lengthPassword=${#password}
  local locUser=/home/wahid/sisop/modul1/users/user.txt
  local locLog=/home/wahid/sisop/modul1/log.txt

    if grep -q $username "$locUser"
    then
	existsUser="User already exists"

	echo $existsUser
	echo $calendar $time REGISTER:ERROR $existsUser >> $locLog

    elif [[ $password == $username ]]
    then
        echo "Password cannot be the same as username"

    elif [[ $lengthPassword -lt 8 ]]
    then
        echo "Password must be more than 8 characters"

    elif [[ "$password" != *[[:upper:]]* || "$password" != *[[:lower:]]* || "$password" != *[0-9]* ]]
    then
	echo "Password must be at least upper, lower and number!"

    else
      	echo "Register successfull!"
      	echo REGISTER:INFO User $username registered successfully >> $locLog
      	echo $calendar $time $username $password >> $locUser
    fi


}


calendar=$(date +%D)
time=$(date +%T)

printf "Enter your username: "
read username

printf "Enter yout password: "
read -s password

func_check_password
