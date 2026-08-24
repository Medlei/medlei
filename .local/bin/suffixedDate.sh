#!/bin/sh

date=`date +%d`

case `expr $date % 10` in
	1) dateSuffix=st;;
	2) dateSuffix=nd;;
	3) dateSuffix=rd;;
	*) dateSuffix=th
esac

echo $date$dateSuffix