#!/bin/bash

grep 'Rotatory Strengths' -A31 N_dimer_PTCDIexc.out| tail -n 31 > Rotatory_Strengths.txt
grep 'Excited State' N_dimer_PTCDIexc.out > Excited_State.txt
touch CD_wave.in
