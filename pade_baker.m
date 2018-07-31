%Copyright (C) 2007-2018 Fredrik Karlsson (karlsson.fredrik@gmail.com)
%All rights reserved

function [n, t, n1, t1] = pade(C, J)

N = length(C)-1;

n_2 = zeros(size(C));
n_1 = zeros(size(C));
n   = zeros(size(C));
n1  = zeros(size(C));


t_2 = zeros(size(C));
t_1 = zeros(size(C));
t   = zeros(size(C));
t1  = zeros(size(C));


n_2(1:(N+1)) = C(1:(N+1));
n_1(1:N) = C(1:N);

t_2(1) = 1;
t_1(1) = 1;

for j=1:J  
    n = n_1( N-j  +1)*n_2-n_2( N-(j-1) +1)*x(n_1);
    t = n_1( N-j  +1)*t_2-n_2( N-(j-1) +1)*x(t_1);

    n1 = n( N-j +1)*n_1-n_1( N-j +1)*n;
    t1 = n( N-j +1)*t_1-n_1( N-j +1)*t;
    
    norm = abs(t(1));
    norm1 = abs(t1(1));

    n = n/norm; n1 = n1/norm1;
    t = t/norm; t1 = t1/norm1;
        
    n_2 = n;
    n_1 = n1;
    t_2 = t;
    t_1 = t1;    
    
end    
    
function n = x(n);
N = length(n);
n(2:N) = n(1:(N-1));
n(1) = 0;
