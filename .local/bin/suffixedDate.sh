#/bin/sh

command -v date &>/dev/null && {
	date=`date +%d`

	command -v expr &>/dev/null && case `expr $date % 10` in
		*) dateSuffix=th;;
		1) dateSuffix=st;;
		2) dateSuffix=nd;;
		3) dateSuffix=rd
	esac

	echo $date$dateSuffix
}