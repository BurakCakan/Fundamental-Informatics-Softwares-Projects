%Burak Çakan - 702201003
format long;
n=1000;

%At first, I used full matrix like below in calculations but I took memory error so I quit using full matrix.
%matrix=full(sparse(randi(100000,1,10000),randi(100000,1,10000),rand(1,10000),100000,100000));

%Then, I found a special function to have 5 banded sparse matrix as below. BUt the requested one was sparse() especially and I quit spidiags 
%a=rand(n,1);
%matrix=spdiags([rand*a rand*a rand*a rand*a rand*a],-2:2,n,n); % 5 banded sparse matrix

% In sparse() function, there was no short-cut way of creating 5 banded sparse matrix like spidiags. Hence, I wanted to formulize the locations...
%(cont'd) of coordinates that must be non-zero for 5 banded sparse matrix. Thee relations are the following: (i=j),(i=j+1), (i=j+2), (j=i+1), (j=i+2)
%According to these relations between i and j, I stored the coordinates in row() and col() arrays. I formulated the total number of nnz values as...
%(cont'd) 5n-6. These nnz values are stored in val array in order to match each coordinate in row and col. The following loop is for these formualtions:
for i=1:n % for (i=j)
	row(i) = i;
	col(i) = i;
	if (i != n) % for (i=j+1) and (j=i+1)
		row(n+i) =i+1;
		col(n+i) =i;
		row(3*n-3+i) = i;
		col(3*n-3+i) = i+1;
		if (i != n-1) %for (i=j+2) and (j=i+2)
			row(2*n-1+i) = i+2;
			col(2*n-1+i) = i;
			row(4*n-4+i) = i;
			col(4*n-4+i) = i+2;
		end
	end
end

val = rand(1,5*n-6);
matrix = sparse(row,col,val,n,n); % This function created 5 banded sparse matrix.

vector=rand(n,1);

% line 38-50: convertion to csr format
countval=0;
countrow=0;
row_ind(1)=0;
for i=1:n
	for j=1:n
		if(matrix(i,j)!=0)
			countval+=1;
			val(countval)=matrix(i,j);
			col_ind(countval)=j;
		end
	end
	row_ind(i+1) = countval;
end

% line 55-59: multiplication with csr format
result = zeros(n,1);
disp('Execution time for multiplication with csr:')
tic
for i=1:n
	for j=row_ind(i)+1:row_ind(i+1)
		result(i) = result(i)+val(j)*vector(col_ind(j));
	end
end
toc

disp('Execution time for multiplication w/o csr (sparse()*vector):')
tic
matrix*vector; % multiplication w/o csr
toc




