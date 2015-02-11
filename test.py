#!/usr/bin/python

# This is Python.

# --Configuration--

EXECUTABLE = './parser'
TEST_DIR = './test/tests'
TEMP_FILE = 'tmp.txt'

import os

os.system('make')

numPassed = 0
totalCases = 0

for root, dirs, files in os.walk(TEST_DIR):
    for testFile in sorted(files):
        totalCases += 1

        ret = os.system('%s %s/%s > %s 2>&1' % (EXECUTABLE, TEST_DIR, testFile, TEMP_FILE))
        expectedErr = testFile.startswith('err')

        if (ret == 0 and expectedErr):
            print 'FAIL: "%s" Expected to fail parsing.' % testFile
        elif (ret != 0 and not expectedErr):
            print 'FAIL: "%s" Expected to pass parsing:' % testFile
            print '----------'
            os.system('cat tmp.txt')
            print '----------'
        else:
            numPassed += 1
            print 'PASS: %s' % testFile

os.system('rm %s' % TEMP_FILE)

print
print 'Number of passed test cases: %d/%d' % (numPassed, totalCases)

