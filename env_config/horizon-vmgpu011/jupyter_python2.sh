#!/bin/bash
export PYTHONPATH=/home/austin/.local/lib/python2.7/site-packages:$PYTHONPATH
source ~/py2_kernel/bin/activate
which python

jupyter notebook --NotebookApp.contents_manager_class='notedown.NotedownContentsManager'
