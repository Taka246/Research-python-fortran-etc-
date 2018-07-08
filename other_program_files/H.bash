#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -q xh1.q
#$ -pe x24 48
#$ -j y
#$ -N H
hostname

export OMP_NUM_THREADS=1
export I_MPI_ADJUST_ALLGATHERV=2
export I_MPI_PIN=1

python make_csv_H.py
