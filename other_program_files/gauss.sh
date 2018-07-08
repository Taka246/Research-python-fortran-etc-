#!/bin/bash

#mkdir gauss

cp nfinp_1 nfinp_1rlx

#pushd ~/STATE/Analysis
#ifort -o repeat_1x1.fep repeat_1x1.f
#popd
#~/STATE/Analysis/repeat_1x1.fep < nfinp_1rlx > nfinp_1rlx.xyz
repeat_1x1.fep < nfinp_1rlx > nfinp_1rlx.xyz # ?_dimer_PTCDI.com  xyzfile
#Cd Gauss/
#Cp ~/State/Outs/Ptcdi_Monomer/Gauss/Run.Sh .
#cp ~/STATE/outs/PTCDI_monomer/gauss/PTCDI.com .
#cp ~/STATE/outs/PTCDI_monomer/gauss/PTCDIexc.com .
