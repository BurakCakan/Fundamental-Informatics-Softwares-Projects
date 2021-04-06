! Burak Çakan - 702201003
program cholesky
implicit none
real,allocatable,dimension(:,:)::A,U,L 
real,allocatable,dimension(:)::B,X,Y
integer::n,i,j,k
real::sum

write(*,*) "Enter the dimension size of the symmetric matrix:"
read(*,*) n

allocate(A(n,n))
allocate(U(n,n))
allocate(L(n,n))
allocate(B(n))
allocate(X(n))
allocate(Y(n))

do i=1,n
	do j=1,n
		write(*,'(A,i2,A,i2,A)') "Enter the",i,"th row and ",j,"th column of the symmetric matrix"
		read(*,*) A(i,j)
	end do
end do 

write(*,*) "Enter the values of the array"
do i=1,n
	read(*,*) B(i)
end do

U(:,:)=0.
L(:,:)=0.
Y(:)=0.
X(:)=0.

L(1,1)= SQRT(A(1,1))
do i=2,n
	do j=1,n
		if (i==j) then
			sum=0.
			do k=1,i-1
				sum = sum + L(i,k)*L(i,k)
			end do
			L(i,j)=SQRT(A(i,j)-sum)
		else if (i > j) then
			sum=0.
			do k=1,j-1
				sum = sum + L(i,k)*L(j,k)
			end do
			L(i,j)=1/L(j,j)*(A(i,j)-sum)
		end if
	end do
end do

U = TRANSPOSE(L)

Y(1)=B(1)/L(1,1)
do i=2,n
	sum = 0
	do j=1,i-1
		sum = sum + L(i,j)*Y(j)
	end do
	Y(i)=(B(i)-sum)/L(i,i)
end do

X(n)=Y(n)/U(n,n)
do i = n-1,1,-1
	sum = 0
	do k = n,i+1,-1
		sum = sum + U(i,k)*X(k)
	end do
	X(i) =(Y(i)-sum)/U(i,i)
end do

write(*,*) "Matrix of U is as follows:"
do i=1,n
	write(*,*) U(i,:)
end do 

write(*,*) "Solution array of x is as follows:"
do i=1,n
	write(*,*) X(i)
end do 

deallocate(A)
deallocate(U)
deallocate(L)
deallocate(B)
deallocate(X)
deallocate(Y)
end program cholesky