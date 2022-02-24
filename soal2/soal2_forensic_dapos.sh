#!/bin/bash
locFolder=/home/wahid/sisop/modul1/forensic_log_website_daffainfo_log
locLog=$locFolder/log_website_daffainfo.log
locRata=$locFolder/ratarata.txt
locResult=$locFolder/result.txt

#B
cat $locLog | awk -F: '{gsub(/"/, "", $3)
	arr[$3]++}
	END {
		for (i in arr) {
			count++
			res+=arr[i]
		}
		res/=count
		printf "rata rata serangan perjam adalah sebanyak %.3f request per jam\n\n", res
	}' >> $locRata

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
	}' >> $locResult

#D
cat $locLog | awk '/curl/ {++n} END {
print "ada " n " request yang menggunakan curl sebagai user-agent\n"}' >> $locResult

#E
cat $locLog | awk -F: '/2022:02/ {gsub(/"/, "", $1)
	arr[$1]++}
	END {
		for (i in arr){
			print i " Jam 2 Pagi"
		}
	}' >> $locResult
