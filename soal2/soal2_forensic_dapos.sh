#!/bin/bash
locFolder=/home/wahid/sisop/modul1/forensic_log_website_daffainfo_log
locLog=$locFolder/log_website_daffainfo.log
locRata=$locFolder/ratarata.txt
locResult=$locFolder/result.txt

#B
cat $locLog | awk '{split($0,a,":")
	b[a[2]":"a[3]"\""]++}
		END{
			for(i in b) {
		 		count++
			 	summ+=b[i]
			}
			summ=summ/count
			echo "rata rata serangan perjam adalah sebanyak %.3f request per jam " $summ;
		}' >> $locRata

#C
cat $locLog | awk '{split($0,a,":")
	b[a[1]]++}
		END{
			max = 0
			target
			for(i in b) {
				if (max < b[i]){
					target = i
					max = b[target]
				}
			}
			echo "yang paling banyak menagkses server adalah : " target " sebanyak " max " request\n"
		}' >> $locResult

#D
cat $locLog  | awk '/curl/  { ++n }
END   { print "ada", n, "request yang menggunakan curl sebagai user-agent\n" }' >> result.txt

#E
cat $locLog | awk '/22\/Jan\/2022:02/{
	split($0,a,":")
	b[a[1]]++
	count++}END{
		for (i in b){
			echo i " IP Address Jam 2 Pagi"
		}
	}' >> $locResult
