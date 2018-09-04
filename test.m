N=48;
n=1:N-1;
ind=gcd(n,N)==1;
tot=n(ind);
display(size(tot,2));