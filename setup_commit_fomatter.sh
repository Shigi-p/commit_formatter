#!/usr/bin/env sh

chmod +x commit_formatter.py
echo "alias gcommit=\"python3 `pwd`/commit_formatter.py\"" >> ~/.bashrc
source ~/.bashrc
