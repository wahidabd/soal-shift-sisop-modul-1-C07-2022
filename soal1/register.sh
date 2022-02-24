func_check_password() {
  local lengthPassword=${#password}
  local locFolder=/home/wahid/sisop/modul1
  local locUsers=$locFolder/users

    if [[ ! -d "$locUsers" ]]
    then
	mkdir $locUsers
    fi


    if grep -q $username "$locUsers/user.txt"
    then
	existsUser="User already exists"

	echo $existsUser
	echo $calendar $time REGISTER:ERROR $existsUser >> $locFolder/log.txt

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
      	echo $calendar $time REGISTER:INFO User $username registered successfully >> $locFolder/log.txt
      	echo $username $password >> $locUsers/user.txt
    fi


}


calendar=$(date +%D)
time=$(date +%T)

printf "Enter your username: "
read username

printf "Enter yout password: "
read -s password

func_check_password
