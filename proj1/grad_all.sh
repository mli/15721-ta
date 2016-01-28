#!/bin/bash

# set -x
email=1
my_dir=`pwd`/`dirname $0`
handin_dir=/afs/cs/academic/class/15721-s16/autolab/project1/handin/
# handin_dir=/tmp

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


    res=results && rm -rf $res

    legal=`grep GetHashTable $file | wc -l`
    leak=`grep "ERROR SUMMARY: 0 errors from 0 contexts" $log | wc -l`
    style=`grep "^<" $log | wc -l`

    t1=`grep "\[       OK \] JoinTests.BasicTest" | wc -l`
    t2=`grep "\[       OK \] JoinTests.EmptyTablesTest" | wc -l`
    t3=`grep "\[       OK \] JoinTests.JoinTypesTest" | wc -l`
    t4=`grep "\[       OK \] JoinTests.ComplicatedTest" | wc -l`

    if [ $legal -eq 0 ]; then
        echo "you need to implement based on GetHashTable" >>$res
        echo "$andrew,0,0" >>scores
    elif [ $leak -eq 0 ]; then
        echo "failed leak check" >>$res
        echo "$andrew,0,0" >>scores
    else
        if [ $style -eq 0 ]; then
            style=10
        else
            style=0
        fi
        test=0
        if [ $t1 -eq  1 ]; then
            test+=5
        fi
        if [ $t2 -eq  1 ]; then
            test+=10
        fi
        if [ $t3 -eq  1 ]; then
            test+=10
        fi
        if [ $t4 -eq  1 ]; then
            test+=15
        fi

        echo "style check score: $style / 10" >>$res
        echo "join test score: $test / 40" >>$res
        echo "$andrew,$test,$style" >>scores
    fi

    if [ $email -ne 0 ]; then
        scp -P 1332 $res $log cmu15721@fw.cmcl.cs.cmu.edu:~/
        ssh -p 1332 cmu15721@fw.cmcl.cs.cmu.edu 15721-ta/sendmail.sh \
            $andrew $res `basename $log` "15721: Submission $id results for Project 1"
    fi
done
