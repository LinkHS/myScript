#!/bin/bash
set -x
notedown $1 --to markdown --strip > tmp.jupyter.md && mv tmp.jupyter.md $1
