#!/usr/bin/env python

import random
import re

WHITESPACE_RE = re.compile(r"^\s*$")

TEXT = 'draft2.txt'

SPACING = 10

# randomly pick one line from each paragraph

lines = []

n = 0

with open(TEXT, 'r') as fh:
	for line in fh.readlines():
		if line[:6] == 'I will':
			if lines:
				if n % SPACING == 0:
					print(random.choice(lines))
				lines = []
				n += 1
		if not WHITESPACE_RE.match(line):
			lines.append(line[:-1])

print(random.choice(lines))