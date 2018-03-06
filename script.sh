#!/bin/bash

sudo airmon-ng start wlo1 

echo press q/Q to quit taking values

#while true; do
matlab_print=3 ;
end=$((SECONDS+900))
while [ $SECONDS -lt $end ]; do
	
	sudo tshark -i mon0 -a duration:60 -T fields -e wlan_radio.signal_dbm -e wlan_radio.channel -e wlan_radio.duration -e wlan.fcs.status -e wlan_radio.data_rate  |tee -a test2.csv


	read -t 0 -N 1 input
	if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
		# The following line is for the prompt to appear on a new line.
		
		matlab -nodesktop -r scripts1
		let matlab_print=2;
		echo Plots have been generated		
		break
	fi

	# wait for 30 seconds
	echo timeout of 30 seconds, if you want to process data presss q/Q
	read -t 30 -N 1 input

	# if q is pressed
	if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
		# The following line is for the prompt to appear on a new line.
		
		matlab -nodesktop -r scripts1
		let matlab_print=2;
		echo Plots have been generated
		break
	fi
done

if [ $matlab_print -ge 3 ];then
	matlab -nodesktop -r scripts1
	echo Plots have been generated
fi

sudo airmon-ng stop mon0
