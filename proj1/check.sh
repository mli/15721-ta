#!/bin/bash
# set -x
file=$1

my_dir=`pwd`/`dirname $0`
cp $file $my_dir/hash_join_executor.cpp || exit -1

handin_dir=/handin
peloton_dir=/peloton

# test join_test.log
docker run -v $my_dir:$handin_dir muli/peloton:proj1 \
    /bin/bash -c " \
     cp $handin_dir/hash_join_executor.cpp $peloton_dir/src/backend/executor/ && \
     cp $handin_dir/join_test.cpp $peloton_dir/tests/executor/ && \
     cd $peloton_dir && git pull && \
     cd $peloton_dir/build && make -j4 && cd tests && make check-build -j4 && \
     valgrind --leak-check=yes --trace-children=yes --track-origins=yes ./join_test" \
    | tee join_test.log

# check style
docker run -v $my_dir:$handin_dir muli/peloton:proj1 \
    /bin/bash -c "clang-format-3.6 --style=file $handin_dir/hash_join_executor.cpp | diff $handin_dir/hash_join_executor.cpp - " | tee style_check.log
