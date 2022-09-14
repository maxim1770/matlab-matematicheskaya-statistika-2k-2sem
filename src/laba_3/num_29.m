clear
clc
%1.1
N=10000;
X=random('Logistic',-2,1,1,N);

x_min=min(X);
x_max=max(X);

r=floor(log2(N))+1;
h=(x_max-x_min)/r;

for i=1:r+1
    z(i)=x_min+(i-1)*h;
end

z1=z+h/2;
z2=z1(1:r);

U=hist(X,z2);

%1.2
F = cdf('Logistic',z,-2,1);
for i=1:14
    p(i)=F(i+1)-F(i);
end

G=0;
for i=1:14
    G=G+((U(i)-N*p(i))^2)/(N*p(i))
end

%1.3
a1=0.1;
a2=0.05;
a3=0.01;
hi1=chi2inv(1-a1,r-1);
hi2=chi2inv(1-a2,r-1);
hi3=chi2inv(1-a3,r-1);

%1.4
%G<h1(2,3)=>гипотеза о том, что наблюдаемые данные согласуются с заданным
%законом распределения верна


%2.1
x_min=min(X);
x_max=max(X);
x=x_min:0.01:x_max;
for i = 1:length(x)
    func(i) = sum(X<=(x_min+i*0.01))/N;
end
%func=func/N;
func0=cdf('Logistic',x,-2,1);
%plot(x,func)
%hold on
%plot(x,func0,'-y')
D=sqrt(N)*max(abs(func-func0))
%2.2
%k1=1.23,k2=1.35,k3=1.62
%2.3
%D<k1(2,3)=>гипотеза о том, что наблюдаемые данные согласуются с заданным
%законом распределения верна

%3.2
%Y=random('Logistic',-2,1,1,N);
b=random('Normal',0,0.1,1,N);
Y=2*X+b;
%3.3
ro=(sum(X.*Y)/(N-1)-mean(X)*mean(Y))/sqrt(var(X)*var(Y));
%3.4
T=ro*sqrt(N-2)/sqrt(1-ro^2);
%3.5
ro1=tinv(1-a1,N-2);
ro2=tinv(1-a2,N-2);
ro3=tinv(1-a3,N-2);
%3.6
%T<ro1(2,3)=>гипотеза о том, что коэф.корр.=0 принимается