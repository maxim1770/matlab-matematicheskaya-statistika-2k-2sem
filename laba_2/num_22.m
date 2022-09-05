% Лаба 2 Вариант 22 Нормальное распределение: μ=1, σ=4


clear
clc

%-----Пункт 1------ (+)
N=10000;
mu = 1;
sigma = 4;
X = random('Normal', mu, sigma, N, 1);

%-----Пункт 2.1------ (+)
sigma_MM = 4 * (1/pi) * (sum(X)/N)^2;

%N=input("input: ");
for i=1:1002
    X = random('Normal', mu, sigma, N, 1);
    sigma_1(i)= 4 * (1/pi) * (sum(X)/N)^2;
    sigma(i)=3;
end

plot(sigma_1);
hold on
plot(sigma)
hold off


N=input("input: ");
X = random('Normal', mu, sigma, N, 1);
[y,v]=lnmp(X,N);
k=1:0.05:10;
figure
plot(k,y);
for i=1:1000
    %N=input("input: ");
    X = random('Normal', mu, sigma, 10, 1);
    [b,c]=lnmp(X, 10);
    v1(i)=c;
end
X = random('Normal', mu, sigma, 10, 1);
[b,c]=lnmp(X, 10);
figure
hold on
plot(k,b);
X = random('Normal', mu, sigma, 100, 1);
[b,c]=lnmp(X,100);
plot(k,b);
X = random('Normal', mu, sigma, 10000, 1);
[b,c]=lnmp(X, 1000);
plot(k,b);
hold off

%-----Пункт 2.2------ (+)

for i=1:100
    %N=input("input: ");
    X = random('Normal', mu, sigma, 1000, 1);
    [b,c]=lnmp(X,1000);
    v1(i)=c;
    dysp(i)=var(X,1);
end
m=mean(v1);
m_dysp=mean(dysp);
dysp_v1=var(v1,1);

%-----Пункт 2.3------ (+)
%2.3, 3.1 , 3.2, 3.3

figure

N=input("input: ");
X = random('Normal', mu, sigma, N, 1);

r=floor(log2(N))+1;
X_max=max(X);
X_min=min(X);
h=(X_max-X_min)/r;

for i=1:r+1
    z(i)=X_min+(i-1)*h;
end

z1=z+h/2;
z2=z1(1:r)
U=hist(X, z2);
bar(z2,U/(h*N),1);
x=-10:0.001:10;

% В этом не уверен
f=pdf('Normal',x, mu, sigma);
sigma_MM = 4 * (1/pi) * (sum(X)/N)^2;

% В этом не уверен
f1=pdf('Normal',x, mu,sigma_MM);
hold on
plot(x,f);
plot(x,f1);
hold off

%-----Пункт 3.3------ (+)
% 3.3 , 4

y_emp(1)=U(1)/N;
  for i=2:r
      y_emp(i)=y_emp(i-1)+U(i)/N;
  end
figure
hold on
stairs(z2,y_emp);

x_teor=-10:0.05:10;

% В этом не уверен
y_teor = cdf('Normal',x_teor, mu,sigma_MM);
plot(x_teor,y_teor)
figure
x_teor_2=-10:0.05:10;

% В этом не уверен
y_teor_2 = cdf('Normal',x_teor_2, mu, sigma_MM);
plot(x_teor_2, y_teor_2)
hold off

function [y,v]=lnmp(x,N)
k=1:0.05:10;
for j=1:181
    y(j)=0;
for i=1:N
   y(j)=y(j)+log(x(i)*2/k(j)) + log(exp(-x(i)*x(i)*1/k(j)));
end
end
max=y(1);
v=k(1);
for i=1:181
   if max<y(i)
       max=y(i);
       v=k(i);
   end
end
end

