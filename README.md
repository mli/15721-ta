# 15721-ta

The scripts here are used to replace some functionalities of
[autolab](https://autolab.andrew.cmu.edu/courses/15721-s16/), since it is
nontrivial to compile and test [peloton](https://github.com/cmu-db/peloton) on
autolab's RHEL image.

**To use these scripts, you need to have [docker](https://docs.docker.com/)
installed on your machine.**

### [Project 1: Hash Join Operator](http://15721.courses.cs.cmu.edu/spring2016/project1.html)

Assume your implemented `hash_join_executor.cpp` is located at
`your/path/hash_join_executor.cpp`, you can check score by

```bash
./proj1/check.sh your/path/hash_join_executor.cpp
```

If every goes well, the last a few lines of the output should look like as following:

```bash
[----------] Global test environment tear-down
[==========] 4 tests from 1 test case ran. (1637 ms total)
[  PASSED  ] 4 tests.
==837==
==837== HEAP SUMMARY:
==837==     in use at exit: 0 bytes in 0 blocks
==837==   total heap usage: 27,695 allocs, 27,695 frees, 191,428,966 bytes allocated
==837==
==837== All heap blocks were freed -- no leaks are possible
==837==
==837== For counts of detected and suppressed errors, rerun with: -v
==837== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```

### For TA usage

Run the testing deamon, which automatically builds every new submission and emails back the results. 

```bash
nohup proj1/deamon.sh &
```
