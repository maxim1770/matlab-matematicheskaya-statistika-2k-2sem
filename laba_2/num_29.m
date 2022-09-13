clear
clc
%1
N=10000;
X=random('Logistic',-2,1,1,10000);


%фикс s=1,оцениваем m

%2

%2.1
m0_MM=mean(X);

for i=1:1000
    X1=random('Logistic',-2,1,10,1);
    m1_MM(i)=mean(X1);
end

for i=1:1000
    X2=random('Logistic',-2,1,100,1);
    m2_MM(i)=mean(X2);
end

for i=1:1000
    X3=random('Logistic',-2,1,1000,1);
    m3_MM(i)=mean(X3);
end

figure
plot(m1_MM)

hold on
plot(m2_MM,'-y')

plot(m3_MM,'-r')
 Ox=1:1000;
 Oy=-2*ones(1,length(Ox));
 plot(Ox,Oy);
 hold off;

%2.2 ММП
m_MMP=-5:0.01:0;
for i=1:length(m_MMP)
       F(i)=-sum(X-m_MMP(i))-2*sum(log(exp(-(X-m_MMP(i)))+1));
end

figure
plot(m_MMP,F)

max_F=-4e04;
m0_MMP=-5;
for i=1:length(m_MMP)
  if F(i)>=max_F
      max_F=F(i);
      m0_MMP=m_MMP(i);
  end
end


%2.3
 b=(sum(m1_MM)/1000)+2;
 v=sum(((m1_MM)+2).^2)/1000;
 D=var(m1_MM);

%3
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

bar(z2,U/(h*N),1);

x=-10:0.001:10;
f1=pdf('Logistic',x,-2,1);
f2=pdf('Logistic',x,m0_MM,1);
hold on
plot(x,f1);
hold on
plot(x,f2,'-y');
hold off



%4
xN=sort(X);
yN=1/N:1/N:1;
stairs(xN,yN);

%теоретическая функция распределения
hold on
xT=-10:0.05:10;
yT = cdf('Logistic',xT,-2,1);
plot(xT,yT)

%теоретическая функция распределения с оценкой
hold on
xT=-10:0.05:10;
yT = cdf('Logistic',xT,m0_MM,1);
plot(xT,yT)

hold off
