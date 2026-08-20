#/bin/sh

date=`date +%d`

case $(($date % 10)) in
	*) dateSuffix=th;;
	1) dateSuffix=st;;
	2) dateSuffix=nd;;
	3) dateSuffix=rd
esac

echo $date$dateSuffix