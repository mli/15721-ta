#!/bin/bash
my_dir=`pwd`/`dirname $0`

while true; do
    $my_dir/grad_all.sh
    echo "`date`: sleep 60 sec"
    sleep 60
done

# ssh -p 1332 cmu15721@fw.cmcl.cs.cmu.edu 'bash -s' <<EOF
# mail -s "15721 script stopped" muli.cmu@gmail.com </dev/null
# EOF
