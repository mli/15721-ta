#!/bin/bash

email=$1
shift
body=$1
shift
log=$1
shift
title=$@

mail -s "$title" -a $log $email <$body
