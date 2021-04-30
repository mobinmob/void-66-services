#!/usr/bin/env bash
do_unlock_device() {
	# $1 = requested name
	# $2 = source device
	# $3 = password
	# $4 = options
	local open=create a=$1 b=$2 failed=0 opts
	# Ordering of options is different if you are using LUKS vs. not.
	# Use ugly swizzling to deal with it.
	# isLuks only gives an exit code but no output to stdout or stderr.
	if cryptsetup isLuks "$2" 2>/dev/null; then
		open=luksOpen
		a=$2
		b=$1
	else
		echo "Non-LUKS partitions are not supported at the moment."
		return
	fi
	if [[ $4 ]]; then
		for i in ${4//,/ }; do
			case $i in
				"discard") opts+="--allow-discards" ;;
				"readonly"|"read-only") opts+="--readonly" ;;
				"tries"*) opts+="-T ${i##*=}" ;;
				"keyfile-size"*) opts+="-l ${i##*=}" ;;
				"keyfile-offset"*) opts+="--keyfile-offset ${i##*=}" ;;
				"key-slot"*) opts+="-S ${i##*=}" ;;
				*)
					continue
				;;
			esac
		done
	fi
	case $3 in
		/dev*)
			local ckdev=${3%%:*}
			local cka=${3#*:}
			local ckb=${cka#*:}
			local cka=${cka%:*}
			local ckfile=/dev/ckfile
			local ckdir=/dev/ckdir
			case ${cka} in
				*[!0-9]*)
					# Use a file on the device
					# cka is not numeric: cka=filesystem, ckb=path
					mkdir ${ckdir}
					mount -r -t ${cka} ${ckdev} ${ckdir}
					dd if=${ckdir}/${ckb} of=${ckfile} >/dev/null 2>&1
					umount ${ckdir}
					rmdir ${ckdir};;
				*)
					# Read raw data from the block device
					# cka is numeric: cka=offset, ckb=length
					dd if=${ckdev} of=${ckfile} bs=1 skip=${cka} count=${ckb} >/dev/null 2>&1;;
			esac
			cryptsetup -d ${ckfile} $opts $open "$a" "$b" >/dev/null
			dd if=/dev/urandom of=${ckfile} bs=1 count=$(stat -c %s ${ckfile}) conv=notrunc >/dev/null 2>&1
			rm ${ckfile};;
		/*)
			cryptsetup -d "$3" $opts $open "$a" "$b" >/dev/null;;
		"none" | "")
			cryptsetup $opts $open "$a" "$b" >/dev/null;;
	esac
	return $?
}

do_unlock() {
	local name=$1 device=$2 password=$3 options=$4

	if [[ ${options:0:2} =~ -. ]]; then
		do_unlock_device "$name" "$device" "$password" "$options"
		return $?
	fi

	do_unlock_device "$name" "$device" "$password" "$options"
	failed=$?
	if (( $failed )); then
		printf "${C_FAIL}Unlocking of $1 failed.${C_CLEAR}\n"
	fi
	return $?
}

read_crypttab() {
	local line nspo
	while read line <&3; do
		[[ $line && $line != '#'* ]] || continue
		eval nspo=("${line%#*}")
		do_unlock "${nspo[0]}" "${nspo[1]}" "${nspo[2]}" "${nspo[3]}"
	done 3< /etc/crypttab
}

read_crypttab
vgchange --sysinit -a y &> /dev/null
