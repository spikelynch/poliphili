#!/usr/bin/env python


from pathlib import Path
from shutil import copy

src = Path("./figures/")
dest = Path("./illustrations2/renumbered/")

for f in src.glob("*.png"):
	n = int(f.name[:5])
	n += 2
	newf = dest / f"{n:05d}.png"
	print(f"{f} -> f{newf}")
	copy(f, newf)