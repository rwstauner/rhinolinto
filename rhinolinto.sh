#!/bin/bash

while getopts ":f:" arg; do
	case "$arg" in
		f) file="$OPTARG"; shift 2;;
		*) echo "error"; exit 1;;
	esac
done

lib=`dirname $0`

while [[ $# -gt 0 ]]; do
	js="$1";
	shift
	lint=`mktemp /tmp/rhinolinto.XXXXXX`
	{
		if [[ -e "$file" ]]; then
			# TODO: use rhino/javascript instead of perl/JSON::Any
			perl -0777 -MJSON::Any -e '$h = JSON::Any->Load(<>); while(my($k, $v) = each(%$h)){ print "/*$k " . join(", ", map { "$_: " . ($v->{$_} ? "true" : "false") } sort keys %$v), " */\n"; }' "$file";
		fi
		cat $js;
	} > $lint;
	java -cp "$lib/vendor/rhino.jar" org.mozilla.javascript.tools.shell.Main "$lib/vendor/jslint.js" "$lint"
	rm "$lint"
done
