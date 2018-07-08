program H2O_RDF
implicit none
integer, parameter :: natom=208*3,NN=208*3*27,d=500
!totalflame = cutstep + nstep
integer, parameter :: cutstep=51,nstep=50
integer :: i,j,k,l,m,e1(natom),e2(NN),xx,yy,zz
integer :: rrr(natom,NN),nHH(d),nOH(d),nOO(d)
real(8) :: x(natom),y(natom),z(natom),a,b,c,r(natom,NN),rx(NN),ry(NN),rz(NN),rr
real(8) :: p1,p2,p3,dr,rrrr,gHH(d),gOH(d),gOO(d),pi=atan(1.0)*4.0
real(8) :: AVEgHH(d)=0.0d0,AVEgOH(d)=0.0d0,AVEgOO(d)=0.0d0
character*1 ::dummy1,dummy2,dummy3

do l = 1,cutstep
   read(5,*) dummy1
   read(5,*) dummy1,dummy2,dummy3
   do m = 1,natom
      read(5,*) e1(m),x(m),y(m),z(m)
   end do
end do

do l = 1,nstep
        read(5,*) dummy1
        read(5,*) dummy1,dummy2,dummy3
     		do i = 1,natom
	 		read(5,*) e1(i),x(i),y(i),z(i)
		end do
	
	a=18.645
	b=18.645
	c=18.645
	
	e2=-1
    j=0
	
	do xx=-1,1
		do yy=-1,1
			do zz=-1,1
				do i=1,natom
	            	j = i+9*natom*(xx+1)+3*natom*(yy+1)+natom*(zz+1) 
						e2(j) = e1(i) 
					rx(j) = dble(xx)*a+x(i)
					ry(j) = dble(yy)*b+y(i)
					rz(j) = dble(zz)*c+z(i)
				end do
			end do
		end do
	end do			

    nHH(:)=0
    nOH(:)=0
    nOO(:)=0
	
	!$omp parallel
	!$omp do
	do j =1,NN
		do i = 1,natom
			if (i+13*natom/=j) then
			r(i,j) = sqrt((rx(i+13*natom)-rx(j))**2+(ry(i+13*natom)-ry(j))**2+(rz(i+13*natom)-rz(j))**2)
			rr =dble(d)*r(i,j)/(a/2)
			rrr(i,j) = int(rr)
				do k = 1,d
					if(rrr(i,j) == k-1) then
						if((e1(i)+e2(j)) == 2) then
							nHH(k) = nHH(k)+1
						else if((e1(i)+e2(j)) == 3) then
							nOH(k) = nOH(k)+1
						else if((e1(i)+e2(j)) == 4) then
							nOO(k) = nOO(k)+1
						end if
					end if
				end do
			end if
		end do
	end do
	!$omp end do
	!$omp end parallel
	
	p1 = 2.d0*dble(natom)/3.d0/(a*b*c)
	p2 = 2.d0*dble(natom)/3.d0/(a*b*c)
	p3 = dble(natom)/3.d0/(a*b*c)

	dr = a/2/d
	
	do k = 1,d
		rrrr=dr*dble(k)
		gHH(k)=dble(nHH(k))/(4.d0*pi*((rrrr+dr)**3.d0-rrrr**3.d0)*p1/3.d0)/(2.d0*dble(natom)/3.d0)
		gOH(k)=dble(nOH(k))/(4.d0*pi*((rrrr+dr)**3.d0-rrrr**3.d0)*p2/3.d0)/(2.d0*dble(natom)/3.d0)
		gOO(k)=dble(nOO(k))/(4.d0*pi*((rrrr+dr)**3.d0-rrrr**3.d0)*p3/3.d0)/(dble(natom)/3.d0)
        AVEgHH(k)=AVEgHH(k)+gHH(k)
        AVEgOH(k)=AVEgOH(k)+gOH(k)
        AVEgOO(k)=AVEgOO(k)+gOO(k)
	end do        
end do

do k = 1,d
   rrrr = dr * k
   write(*,'(4f15.9)') rrrr,AVEgHH(k)/dble(nstep),AVEgOH(k)/dble(nstep),AVEgOO(k)/dble(nstep)
end do

stop
end program H2O_RDF
