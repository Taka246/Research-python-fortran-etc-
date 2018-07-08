#$ -S /bin/csh
#$ -cwd
#$ -pe x16 96 -q xs2.q
#$ -j y
#$ -N N_dimer_PTCDI

setenv g09root /usr/local/g09/D01
source ${g09root}/g09/bsd/g09.login
setenv systemname N_dimer_PTCDI
setenv GAUSS_SCRDIR /work/nakayama/${systemname}
#set binddir=$[PWD]

#rm -fr /work/nakayama
mkdir /work/nakayama
mkdir $GAUSS_SCRDIR
#rm -f /work/nakayama/BA.chk

${g09root}/g09/g09 -p=$NSLOTS < $PWD/${systemname}.com > $PWD/${systemname}.out
${g09root}/g09/g09 -p=$NSLOTS < $PWD/${systemname}exc.com > $PWD/${systemname}exc.out

