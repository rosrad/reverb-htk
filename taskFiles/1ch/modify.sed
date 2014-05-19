#!/bin/sed -f
s#^.*\(\(c[0-9][0-9a-z]*\)c[0-9].*wav\)#/\2/\1#g
s#^#/cln_test/primary_microphone/si_dt/#g