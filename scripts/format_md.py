#!/usr/bin/env python

import random
import re

WHITESPACE_RE = re.compile(r"^\s*$")

ILL_SPACE = 12

INPUT = 'draft2.md'
ILLUSTRATIONS = 'prompts_final.txt'

lines = []
paras = 0


figures = []

with open(ILLUSTRATIONS, 'r') as fh:
	for line in fh.readlines():
		fig = line[:5]
		caption = line[6:-1]
		figures.append(f"![{caption}](figures/{fig}.png)")



with open(INPUT, 'r') as fh:
	for line in fh.readlines():
		if line[:6] == 'I will':
			if lines:
				print(" ".join(lines))
				print("")
				lines = []
				paras += 1
				if figures and paras % ILL_SPACE == 0:
					print("")
					print(figures.pop(0))
					print("")
		if not WHITESPACE_RE.match(line):
			lines.append(line[:-1])

print(" ".join(lines))
paras +=1

print(f"\n{paras}")