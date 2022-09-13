clear
clc
%-----1----—
N=10000;
SIGMA=4;
X = random('Rayleigh',SIGMA,N,1);
%-----2---—
%-----2.1--— метод моментов
M=1000;
NN=10;
for i=1:M
xx1=random('Rayleigh',SIGMA,NN,1);
sigmas(i)=SIGMA; %точное значение параметра
sigma(i)= mean(xx1)/(sqrt(pi/2));
x_1(i)=i;
end
figure(1);
hold all;
plot(sigma,'black');
plot(x_1,sigmas,'green');
%----2.2--— метод максимального правдоподобия
X1_test = random('Rayleigh',SIGMA,N,1);
Y = [1:0.01:8]; 
Y_size = size(Y); 
for i=1:Y_size(2) 
 l1(i) = 0; 
end 
for i=1:Y_size(2) 
 for j=1:NN 
 d1(j) = log(X1_test(j)/Y(i)^2)+(-X1_test(j)^2)/(2*Y(i)^2); 
 l1(i) = l1(i)+d1(j); 
 end 
end 
figure(2);
hold on;
title("Функции правдоподобия"); 
plot(Y,l1); 
%Находим положение максимума этой функции
max_y1 = max(l1); 
max_x1 = -1; 
for i=1:Y_size(2) 
 if(l1(i) == max_y1)
     max_x1 = Y(i);
 end 
end 
%----2.3--—
sum_ocenka_mu=sum(mu)/NN;
smesh_ocenka=sum_ocenka_mu-MU;
disp=sum((mu-sum_ocenka_mu).^2)/NN;
rass=sum((mu-MU).^2)/NN;
%----3---—
figure(4);
hold all;
N1=10000;
X_max=max(X);
X_min=min(X);
r=floor(log2(N1))+1;%r- количество столбцов
h=(X_max-X_min)/r;%ширина каждого столбика
%массив границ
for i=1:(r+1)
z(i)=X_min+(i-1)*h;% массив из границ интервалов
end
%массив серединок
z1=z+h/2;%середины интервалов полученные из границ интервалов
z2=z1(1:r);%чтобы не попасть в "пустоту"
U=hist(X,z2);%U - массив частот для каждого интервала, середины которых в z2
bar(z2,U/(h*N1),1);% гистограмма относительных частот
%плотность вероятности
h1=(X_max-X_min)/N1;
for i=1:N1 %цикл от1 до N
xx(i)=X_min+(i-1)*h1;% массив из N точек от мин до макс
end
for i=1:N1
muu=mean(X);
end
summu=sum(muu);
title('Гистограмма и плотность вероятности')
f=pdf('Normal',xx,MU,SIGMA);
f1=pdf('Normal',xx,summu,SIGMA);
hold on
plot(xx,f,'red');
plot(xx,f1,'green')
%----4---—
figure(5);
hold all;
F_teor = cdf ('Normal',xx,MU,SIGMA);
F_teor_1=cdf('Normal',xx,summu,SIGMA);
plot(xx,F_teor,'green');
plot(xx,F_teor_1,'blue');
ecdf(X);% "Эмпирическая по негруппированным