#!/bin/bash

gfortran cd_wave.F	 
./a.out #N=30 C=0.05	 
			 
cp CD_wave_out.txt /home/nakayama/STATE/outs/CD_wave_out_N.txt