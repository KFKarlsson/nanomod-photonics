%Copyright (C) 2007-2018 Fredrik Karlsson (karlsson.fredrik@gmail.com)
%All rights reserved

%Compute the dft spectrum of time signal u sampled in time steps of dt (dx/c)
%a: number of dx per unit length
%f0 (c/a) and f1 (c/a): normalized start and stop frequencies in units of 
%Nf: Number for frequency points in the range f0 to f1 


%The normalized conventional fft spectrum of signal u is given by:
%figure; s = abs(fft(u)).^2; s=s/max(s); plot(a*((1:length(s))-1)/(length(s)*dt), s, 'k');



function [I, f]= pade_baker_dft(u, a, dt, f0, f1, Nf)

if nargin<7
    L = 1;
end

[sy, sx] = size(u);
if (sy>sx) u = u'; end

N = length(u);
n = 1:N;

f = linspace(f0, f1, Nf);

I = [];


J = (N-1)/2;
Cn = u;
disp(['Find Pade-approximant   [' num2str(J) ' ' num2str(N-1-J) ']...']);
[P, Q] = pade_baker(Cn, (N-1)/2);
z = exp(-1i*(dt*L/a)*2*pi*f); 
for i=1:length(f);
    if ~mod(i, 1000)
        disp([num2str(i) '   [' num2str(J) ' ' num2str(N-1-J) ']']);
    end
     
    I(i) = polyval(P, z(i))/polyval(Q, z(i));
end