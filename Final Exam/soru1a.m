# Burak Cakan - 702201003 - 25/01/2021
%format long;
clc;
clear all;

epsilon=1e-10;
simp_error=100;
n=1;
while(simp_error>epsilon)

f=@(x)exp(x);

a=0.0;
b=1.0;

h=(b-a)/n;

odd=0;
even=0;

for i=1:1:n-1
	if(rem(i,2)==1)
		odd=odd+f(a+i*h);
	else
		even=even+f(a+i*h);
	end
end

simpson=(h/3)*(f(a)+(4*odd)+(2*even)+f(b));
[area,ierror,nfneval]= quad(f,a,b);
simp_error=abs(simpson-area);
errors(i)=simp_error;
n=n+1;

end

simpson
area
simp_error
n-1

%gnuplot icin degerleri txt dosyasına yazdırıyorum:
gnup=fopen('gnudata.txt','w')
for i=1:length(errors)
	fprintf(gnup,num2str(errors(i)));
	fprintf(gnup,'\n');
end
fclose(gnup);

%graphics_toolkit("gnuplot");

