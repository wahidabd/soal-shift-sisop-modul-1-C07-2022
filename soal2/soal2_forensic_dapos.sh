#!/bin/bash
locFolder=/home/wahid/sisop/modul1/forensic_log_website_daffainfo_log
locLog=$locFolder/log_website_daffainfo.log
locRata=$locFolder/ratarata.txt
locResult=$locFolder/result.txt

#b
#awk -F '"' '{ sum += $4 }
#	END {print sum}' $locLog

#C
#awk -F '"' '{print $2}' $locLog
awk -F '"' '{
		count[$2]++
		}
		END {
			for ( i in count ) echo i, echo count[i]
		}' $locLog
