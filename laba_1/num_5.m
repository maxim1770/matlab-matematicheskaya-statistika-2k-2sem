clear
clc
f1=figure;
f2=figure;

%-----Пункт 1------ (+)
N=1000000;
a = 2;
b = 3;
X=random('Gamma', a, b, N, 1);

%-----Пункт 2------

%-----2.1------(+)
x_min=min(X);
x_max=max(X);
mx_mid=mean(X);%среднее мат ожидание для выборки Х (:) из массива делает вектор
vx_mid=var(X); %средняя дисперсия для выборки Х
vx_mid_ispr=vx_mid*N/(N-1); %средняя исправленная дисперсия для выборки Х
sredn_otrl=std(X);%среднее кв отклонение для выборки Х

%-----2.2------(+)
[mx_teor,vx_teor] = chi2stat(2); %теоретич мат ожидание и дисперсия

%-----2.3------(+)
%N=10
NN1=1000;
M=1000;
sredn_mx=0;
sredn_vx=0;
for l=1:M %цикл от1 до M
    xx1=random('Gamma', a, b, NN1, 1);%генерация выборки
    mx_mid_n10(l)=mean(xx1);
    vx_mid_ispr_n10(l)=var(xx1)*NN1/(NN1-1);
    x_1(l)=l;
    y_1_mx_teor(l)=mx_teor;
    y_1_vx_teor(l)=vx_teor;
    sredn_mx=sredn_mx+mx_mid_n10(l);
    sredn_vx=sredn_vx+vx_mid_ispr_n10(l);
end

figure(f1);
hold all;
plot(mx_mid_n10,'blue');
plot(x_1,y_1_mx_teor,'red');
figure(f2);
hold all;
plot(vx_mid_ispr_n10,'red');
plot(x_1,y_1_vx_teor,'blue');

%-----2.4------(+)
sredn_mx=sredn_mx/M;
sredn_vx=sredn_vx/M;

%-----Пункт 3------(+)
figure;
hold all;
r=floor(log2(N))+1;%целая часть количество интервалов
h=(x_max-x_min)/r;% длина интервалов
for i=1:r+1 %цикл от1 до r+1
    z(i)=x_min+(i-1)*h;% массив из границ интервалов
end
z1=z+(h/2);%середины интервалов полученные из из границ интервалов
z2=z1(1:r);%середины интервалов без лишнего z2-копия z1 от 1 до r
u = hist(X,z2);%u-стал массивом частот для каждого интервала, середины которых в z2
bar(z2,u/(h*N),1);% гистограмма относительных частот
h1=(x_max-x_min)/N;
for j=1:N %цикл от1 до N
    xx(j)=x_min+(j-1)*h1;% массив из N точек от мин до макс-а
end
f=pdf('Gamma', xx, a, b);
plot(xx,f,'green');
plot(z2,u/(h*N),'black'); %полигон относительных частот, точкам из z2 ставится частоты из u деленые на(h*N)


%-----Пункт 4------(+)
mx_mid_group=0;
vx_mid_group=0;
for k=1:r
    mx_mid_group=mx_mid_group+u(k)*z2(k);
end
mx_mid_group=mx_mid_group/N;
for k=1:r
    vx_mid_group=vx_mid_group+u(k)*(z2(k)-mx_mid_group)*(z2(k)-mx_mid_group);
end
vx_mid_group=vx_mid_group/N;


%-----Пункт 5------(+)
figure;
hold all;
F_teor = cdf('Gamma', xx, a, b);
plot(xx,F_teor,'green');
ecdf(X);% "Эмпирическая по негруппированным
uu(1)=0;
z3(1)=0;
for i=1:r %цикл от1 до r+1
    uu(i+1)=uu(i)+u(i)/N;%
    z3(i+1)=z2(i);
end
stairs(z3,uu,"black");