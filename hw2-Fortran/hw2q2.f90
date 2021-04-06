! Burak ÇAKAN - 702201003
program monte_carlo
implicit none

real,parameter::pi=4*ATAN(1.)
real::p,dist,c
integer::i,count
real::r(3)

p=0
count=100000

do
	c = 0
	do i=1,count
		r(1) = RAND()*2-1
		r(2) = RAND()*2-1
		r(3) = RAND()*2-1
		dist = d(r)
		if (dist<=1) then 
			c = c+1
			
		end if
	end do
	p = (c*6)/(REAL(count))
	!write(*,*) p
	if (ABS(pi-p) <= 0.001) exit
	count = count*10
end do

write(*,'(A,F11.8)') "Value of pi: ",p
write(*,'(A,I10)') "Number of random random generated: ",count

contains
  real function d(x)
    real,intent(in)::x(3)
    d = SQRT(x(1)*x(1)+x(2)*x(2)+x(3)*x(3))
    !write(*,*) x(1),x(2),x(3),d
  end function d

end program monte_carlo