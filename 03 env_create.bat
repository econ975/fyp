@echo off
CHCP 65001
conda env create --prefix ./my_env -f ./environment.yml
echo finish
pause