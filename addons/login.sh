#!/bin/bash
if [[ -e /etc/debian_version ]]; then
	OS=debian
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	RCLOCAL='/etc/rc.d/rc.local'
	fi
if [[ "$OS" = 'debian' ]]; then
	data=( `ps aux | grep -i dropbear | awk '{print $2}'`);

	echo "Dropbear login";
	echo "---";

	for PID in "${data[@]}"
	do
		#echo "check $PID";
		NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
		USER=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
		IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
		if [ $NUM -eq 1 ]; then
			echo "$PID - $USER - $IP";
		fi
	done
	echo "---";

	data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

	echo "OpenSSH login";
	echo "---";
	for PID in "${data[@]}"
	do
			#echo "check $PID";
			NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
			USER=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
			IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
			if [ $NUM -eq 1 ]; then
					echo "$PID - $USER - $IP";
			fi
	done
else
	data=( `ps aux | grep -i dropbear | awk '{print $2}'`);

	echo "Dropbear login";
	echo "---";

	for PID in "${data[@]}"
	do
		#echo "check $PID";
		NUM=`cat /var/log/secure | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
		USER=`cat /var/log/secure | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
		IP=`cat /var/log/secure | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
		if [ $NUM -eq 1 ]; then
			echo "$PID - $USER - $IP";
		fi
	done
	echo "---";

	data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);

	echo "OpenSSH login";
	echo "---";
	for PID in "${data[@]}"
	do
			#echo "check $PID";
			NUM=`cat /var/log/secure | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
			USER=`cat /var/log/secure | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
			IP=`cat /var/log/secure | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
			if [ $NUM -eq 1 ]; then
					echo "$PID - $USER - $IP";
			fi
	done
fi
echo "---";
echo ""
touch /var/log/wtmp
echo "====== List PPTP Login ======"
echo "-------------------------------------------------------------------------"
echo " User   Device              IP              Date              Status     "
echo "-------------------------------------------------------------------------"
last | grep still
echo "-------------------------------------------------------------------------"
echo ""
echo "====== History Login ======"
echo "-------------------------------------------------------------------------"
echo " User   Device              IP              Date              Status     "
echo "-------------------------------------------------------------------------"
last | grep ppp
echo "-------------------------------------------------------------------------"
echo "VPS/SSH Mall F2C"