# 15721-ta

The scripts here can be used to replace some functionality of
[autolab](https://autolab.andrew.cmu.edu/courses/15721-s16/), due to it is
nontrivial to compile and test [peloton](https://github.com/cmu-db/peloton) on
autolab's RHEL image.

**To use these scripts, you need to have [docker](https://docs.docker.com/)
installed on your machine.**

### [Project 1: Hash Join Operator](http://15721.courses.cs.cmu.edu/spring2016/project1.html)

Assume your implemented `hash_join_executor.cpp` is located at
`your/path/hash_join_executor.cpp`, check your score by

```bash
./proj1/check.sh your/path/hash_join_executor.cpp
```
