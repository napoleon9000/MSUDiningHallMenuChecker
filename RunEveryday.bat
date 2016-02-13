@echo off
cd M:\My Documents\Matlab\DiningHallMenuChecker\
timeout 50400
:loop
matlab -nodesktop -nosplash -r DHMC_v2
timeout 86400
goto loop