#!/bin/bash
locFolder=/home/wahid/sisop/modul1
locLog=$locFolder/log_website_daffainfo.log
folder=$locFolder/forensic_log_website_daffainfo_log

#check user
if [[ $(id -u) -ne 0 ]]
then
	echo "Please run as root"
	exit 1
fi

#create dir
# A
if [[ -d "$folder" ]]
then
	rm -rf $folder
	mkdir $folder
else
	mkdir $folder
fi

#B
cat $locLog | awk -F: '{gsub(/"/, "", $3)
	arr[$3]++}
	END {
		for (i in arr) {
			count++
			res+=arr[i]
		}
		res=res/count
		printf "rata rata serangan perjam adalah sebanyak %.3f request per jam\n\n", res
	}' >> $folder/ratarata.txt

#C
cat $locLog | awk -F: '{gsub(/"/, "", $1)
	arr[$1]++}
	END {
		max=0
		target
		for (i in arr){
			if (max < arr[i]){
				target = i
				max = arr[target]
			}
		}
		print "yang paling banyak mengakses server adalah: " target " sebanyak " max " request\n"
	}' >> $folder/result.txt

#D
cat $locLog | awk '/curl/ {++n} END {
print "ada " n " request yang menggunakan curl sebagai user-agent\n"}' >> $folder/result.txt

#E
cat $locLog | awk -F: '/2022:02/ {gsub(/"/, "", $1)
	arr[$1]++}
	END {
		for (i in arr){
			print i " Jam 2 Pagi"
		}
	}' >> $folder/result.txt
