clear
clc

%-----Пункт 1------ (+)
N=10000;
 nakagami=random('Nakagami',1,3,N,1);

%-----Пункт 2.1------ (+)
sigma_MM = 4 * (1/pi) * (sum(nakagami)/N)^2;

%N=input("input: ");
for i=1:1002
    nakagami=random('Nakagami',1,3,N,1);
    sigma_1(i)= 4 * (1/pi) * (sum(nakagami)/N)^2;
    sigma(i)=3;
end

plot(sigma_1);
hold on
plot(sigma)
hold off


N=input("input: ");
nakagami=random('Nakagami',1,3,N,1);
[y,v]=lnmp(nakagami,N);
k=1:0.05:10;
figure
plot(k,y);
for i=1:1000
    %N=input("input: ");
    nakagami=random('Nakagami',1,3,10,1);
    [b,c]=lnmp(nakagami,10);
    v1(i)=c;
end
nakagami=random('Nakagami',1,3,10,1);
[b,c]=lnmp(nakagami,10);
figure
hold on
plot(k,b);
nakagami=random('Nakagami',1,3,100,1);
[b,c]=lnmp(nakagami,100);
plot(k,b);
nakagami=random('Nakagami',1,3,10000,1);
[b,c]=lnmp(nakagami,1000);
plot(k,b);
hold off

%-----Пункт 2.2------ (+)

for i=1:100
    %N=input("input: ");
    nakagami=random('Nakagami',1,3,1000,1);
    [b,c]=lnmp(nakagami,1000);
    v1(i)=c;
    dysp(i)=var(nakagami,1);
end
m=mean(v1);
m_dysp=mean(dysp);
dysp_v1=var(v1,1);
 %2.3, 3.1 , 3.2, 3.3

figure

N=input("input: ");
nakagami=random('Nakagami',1,3,N,1);

 r=floor(log2(N))+1;
nakagami_max=max(nakagami);
nakagami_min=min(nakagami);
h=(nakagami_max-nakagami_min)/r;

for i=1:r+1
    z(i)=nakagami_min+(i-1)*h;
end

z1=z+h/2;
z2=z1(1:r)
U=hist(nakagami,z2);
bar(z2,U/(h*N),1);
x=-10:0.001:10;
f=pdf('Nakagami',x,1,3);
sigma_MM = 4 * (1/pi) * (sum(nakagami)/N)^2;
f1=pdf('Nakagami',x,1,sigma_MM);
hold on
plot(x,f);
plot(x,f1);
hold off
% 3.3 , 4
y_emp(1)=U(1)/N;
  for i=2:r
      y_emp(i)=y_emp(i-1)+U(i)/N;
  end
figure
hold on
stairs(z2,y_emp);

x_teor=-10:0.05:10;
y_teor = cdf('Nakagami',x_teor,1,3);
plot(x_teor,y_teor)
figure
x_teor_2=-10:0.05:10;
y_teor_2 = cdf('Nakagami',x_teor_2,1,sigma_MM);
plot(x_teor_2,y_teor_2)
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

