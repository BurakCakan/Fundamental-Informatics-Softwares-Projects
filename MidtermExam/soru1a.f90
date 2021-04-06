! Burak ÇAKAN - 702201003
program Ncircle
implicit none
! r degeri soruda verilmedigi icin birim cember olarak aldim.

real,parameter::pi=4*ATAN(1.)
real::N
integer::count,i
real::area,error
real,allocatable,dimension(:,:)::Errors
allocate(Errors(453,2))

N=3
count=1
do 
	area=N/2*(sin(2*pi/N)) 
	error=pi-area ! r=1 aldigimiz icin pi gercek alana, area estimated alana esittir 
	Errors(count,1)=N
	Errors(count,2)=error
	if (error <= 0.0001) exit
	N = N + 1
	count=count+1
end do

write(*,*) "N value	 Error"
do i=1,SIZE(Errors,1)
	write(*,*) Errors(i,:)
end do

open(1,file="errors.txt",status="unknown") ! b sikkinda gnuplot bastirmak icin yapiyorum
do i=1,SIZE(Errors,1)
	write(1,*) Errors(i,:)
end do
close(1)

call system('gnuplot -p soru1b.gnu') ! b sikkindaki soru1b.gnu dosyasini buradan cagiriyorum
deallocate(Errors)
end program Ncircle