clear
clc
%1.1
N=100;
nakagami=random("Nakagami",1,3,1,N);
%1.2
r=floor(log2(N))+1;
nakagami_max=max(nakagami);
nakagami_min=min(nakagami);
h=(nakagami_max-nakagami_min)/r;

for i=1:r+1
    z(i)=nakagami_min+(i-1)*h;
end

for i=1:r
    interval(i)=0;
end
for i=1:N
    for j=1:r
if (nakagami_min+(j-1)*h<=nakagami(i) && nakagami(i)<nakagami_min+j*h)
    interval(j)=interval(j)+1;
end
    end
end
interval(r)=interval(r)+1;
xi=0;
for i=1:r
xi=xi+((interval(i)-N*h)^2)/(N*h);
end
%2
z1=z+h/2;
z2=z1(1:r);
U=hist(nakagami,z2);
y(1)=U(1)/N;
  for i=2:r
      y(i)=y(i-1)+U(i)/N;
  end

x_teor=0:1:6;
y_teor = cdf('Nakagami',x_teor,1,3);
for i=1:7
    k1(i)=abs(y(i)-y_teor(i));
end
k=sqrt(N)*max(k1);
%part 2
N=1000;
X=random("nakagami",1,3,1,N);
Y=random("nakagami",1,3,1,N);
ro = (mean((X - mean(X)).*((Y - mean(Y)))))/sqrt(var(X).*var(Y));
T = (ro * sqrt(N - 2))/sqrt(1 - power(ro, 2)) ;
%7
N=1000;
X=random("nakagami",1,3,1,N);
Y=2*X+random("normal",0,0.001,1,N);
ro1 = (mean((X - mean(X)).*((Y - mean(Y)))))/sqrt(var(X).*var(Y));
T1 = (ro1 * sqrt(N - 2))/sqrt(1 - power(ro1, 2)) ;


