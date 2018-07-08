if test 1 -eq 1 ; then
 for el in `seq 1 23`  25 28 `seq 43 65` 67 70 ;do
   echo processing $el
   sed -i -e s/^$el\ /C\ / output.xyz
 done
fi
if test 1 -eq 1 ; then
 for el in 24 29 66 71  ;do
   echo processing $el
   sed -i -e s/^$el\ /N\ / output.xyz
 done
fi
if test 1 -eq 1 ; then
 for el in 26 27 30 31 68 69 72 73  ;do
   echo processing $el
   sed -i -e s/^$el\ /O\ / output.xyz
 done
fi
if test 1 -eq 1 ; then
 for el in `seq 123 134`  ;do
   echo processing $el
   sed -i -e s/^$el\ /F\ / output.xyz
 done
fi
if test 1 -eq 1 ; then
 for el in `seq 32 42`  `seq 74 84`  `seq 105 116` ;do
   echo processing $el
   sed -i -e s/^$el\ /H\ / output.xyz
 done
fi
if test 1 -eq 1 ; then
 for el in `seq  85 104`  ;do
   echo processing $el
   sed -i -e s/^$el\ /C\ / output.xyz
 done
fi
if test 1 -eq 1 ; then
 for el in `seq  117 122`  ;do
   echo processing $el
   sed -i -e s/^$el\ /Si\ / output.xyz
 done
fi


