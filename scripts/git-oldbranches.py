#!/usr/bin/env python

import subprocess
from datetime import datetime
import time
import math
import sys


class Colours:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

try:
    age_limit_in_days = int(sys.argv[1])
except:
    age_limit_in_days = 30

if age_limit_in_days < 0:
    age_limit_in_days = 0

# Get the branches - sorted by last commit date.
branch_lines = subprocess \
    .check_output(
        "git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname:short)' refs/remotes/origin",
        shell=True
    ).split("\n")

now_in_days = math.floor(time.time() / 86400)
old_branches = []

for branch_line in filter(None, branch_lines):
    last_commit_date = datetime.strptime(str(branch_line.split(' ')[0]), '%Y-%m-%d')
    branch_name = ' '.join(branch_line.split(' ')[1:])

    last_commit_date_in_days = int(last_commit_date.strftime('%s')) / 86400

    if now_in_days - last_commit_date_in_days >= age_limit_in_days:
        old_branches.append((branch_name, last_commit_date, last_commit_date_in_days))

if len(old_branches) > 0:
    print("Remote branches older than %s days:" % age_limit_in_days)
    for branch_tuple in old_branches:
        print(" " + Colours.OKGREEN + branch_tuple[0] + Colours.ENDC)
        print("  Last commit: %s %s(%d days ago)%s" % (branch_tuple[1].strftime('%Y-%m-%d'), Colours.WARNING, now_in_days - branch_tuple[2], Colours.ENDC))
        print("")

else:
    print("No branches older than %d days." % age_limit_in_days)