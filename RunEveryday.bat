@echo off
cd M:\My Documents\Matlab\DiningHallMenuChecker\
timeout 72000
:loop
matlab -nodesktop -nosplash -r DHMC_v2
timeout 86400
goto loop