#
# Regular cron jobs for the sentencepiece package
#
0 4	* * *	root	[ -x /usr/bin/sentencepiece_maintenance ] && /usr/bin/sentencepiece_maintenance
