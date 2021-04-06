! Burak ÇAKAN - 702201003
program GoldenSearch
implicit none

real,parameter::goldenratio=(sqrt(5.0)-1)/2
real,parameter::pi=4*ATAN(1.)
real::xa,xu,x1,x2,d,area,error
integer::count,N

xa=3
xu=1000
count=1  ! kac iterationda cozdugunu count ile takip ediyorum
d=goldenratio*(xu-xa)
x1=xa+d
x2=xu-d

do
	area=x1/2*(sin(2*pi/x1))
	error=ABS(pi-area)
	if (xu-xa<1) then  ! stopping condition olarak ust ve alt limitin birbirine yaklasmasini kullandim
		N = ceiling(xa) ! kosulu saglayan en kucuk integer degeri bulabilmek icin ceiling kullandim
		exit
	end if
	if (error > 0.0001) then
		xa=x2
		x2=x1
		d=goldenratio*(xu-xa)
		x1=xa+d
	else
		xu=x1
		x1=x2
		d=goldenratio*(xu-xa)
		x2=xu-d
	end if
	
	count=count+1
end do

write(*,*) N
write(*,*) count





end program GoldenSearch