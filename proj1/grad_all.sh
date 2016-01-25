#!/bin/bash

# set -x
email=1
my_dir=`pwd`/`dirname $0`
# handin_dir=/afs/cs/academic/class/15721-s16/autolab/project1/handin/
handin_dir=/tmp

for file in $handin_dir/*.cpp; do
    # check
    andrew=`basename $file | awk 'BEGIN{FS="_"}{print $1}'`
    id=`basename $file | awk 'BEGIN{FS="_"}{print $2}'`
    log=$handin_dir/${andrew}_${id}_output.txt

    if [ -f $log ]; then
        continue
    fi

    echo "grading $file"
    scp -P 1332 $file cmu15721@fw.cmcl.cs.cmu.edu:~/
    ssh -p 1332 cmu15721@fw.cmcl.cs.cmu.edu \
        15721-ta/proj1/check.sh \
        `basename $file` 2>>$log 1>>$log
    echo "log is available at $log"

    # results
    res=results
    rm -rf $res

    style=`grep "^<" $log | wc -l`
    if [ $style -eq 0 ]; then
        r="style check: pass"
    else
        r="style check: fail"
    fi
    echo $r >>$res


    unittest=`grep "\[  PASSED  \] 4 tests" $log | wc -l`
    if [ $unittest -eq 1 ]; then
        r="join test: pass"
    else
        r="join test: fail"
    fi
    echo $r >>$res

    leak=`grep "ERROR SUMMARY: 0 errors from 0 contexts" $log | wc -l`
    if [ $leak -eq 1 ]; then
        r="leak test: pass"
    else
        r="leak test: fail"
    fi
    echo $r >>$res
    cat $res

    echo "" >>$res
    echo "the log is attached." >>$res
    echo "" >>$res
    echo "ps: my apologies if you received this email multiple times:)" >>$res

    if [ $email -ne 0 ]; then
        scp -P 1332 $res $log cmu15721@fw.cmcl.cs.cmu.edu:~/
        ssh -p 1332 cmu15721@fw.cmcl.cs.cmu.edu 15721-ta/sendmail.sh \
            $andrew $res `basename $log` "15721: Submission $id results for Project 1"
    fi

done
