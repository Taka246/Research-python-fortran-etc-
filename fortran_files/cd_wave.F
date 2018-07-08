*Deck CircularDichloism
      program CircularDichloism
      implicit none

      integer :: I,N,X
      real :: B,C,D,F,G,J,K,L,Y,Z,A(100,100),pi,h,e,v

      write (*,*) 'N='
      read (*,*) N
      write (*,*) 'C='
      read (*,*) C

      open (unit=55,file='CD_wave.in')       
      open (unit=66,file='CD_wave_out.txt')


      do I = 1,N
        read (55,*) A(I,1),A(I,2)
      end do

      D=1.0d0
      pi=4*ATAN(D)
      h=6.626
      e=1.602
      v=2.998
      K=(((h*v)/e)**2)*(10**4)
      L=K/C
      write(*,*) L
      do X=2000,6000
       F=0.0d0
       Y=0.1*X
       do I=1,N
C        C=0.05*(A(I,1)**0.5)
        B=SQRT(pi*C)
        E=((1.0d0/Y)-(1.0d0/A(I,1)))**2
        G=(A(I,2)/B)*EXP(-E*L)
        F=F+G
       end do
       write (66,*) Y,F
      end do

      close(55)
      close(66)

      end program
