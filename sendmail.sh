#!/bin/bash

set -x
email=$1
shift
body=$1
shift
log=$1
shift
title=$@

mail -s "$title" $email -a $log <$body
