clear
clc
%-----1----—
N=10000;
MU=1;
SIGMA=4;
X = random('Normal',MU,SIGMA,N,1);
%-----2---—
%-----2.1--— метод моментов
M=1000;
NN=10000;
for i=1:M
xx1=random('Normal',MU,SIGMA,NN,1);
mus(i)=MU; %точное значение параметра
sigmas(i)=SIGMA; %точное значение параметра
mu(i)=mean(xx1); %по методу моментов параметр = мат ожиданию
sigma(i)=sqrt(var(xx1)); %по методу моментов дисперсия = сигма^2
x_1(i)=i;
end
figure(1);
subplot(2,1,1);
hold all;
plot(mu,'blue');
plot(x_1,mus,'red');
subplot(2,1,2);
hold all;
plot(sigma,'black');
plot(x_1,sigmas,'green');
%----2.2--— метод максимального правдоподобия
for i=1:M
X2_2=random('Normal',MU,SIGMA,NN,1);
func= @(x,sigma) -log(sigma)-log(2*pi)/2-((x-2).^2/(2*sigma^2)); %логарифм от функции правдоподбия
func_pr= @(sigma) sum(func(X2_2,sigma)); %логарифм от функции правдоподбия для всей выборки
func_pr2=@(sigma) -func_pr(sigma); %переворачиваем функцию и находим минимум
ocenka_max_p(i)=fminbnd(func_pr2,0,10);
end
figure(2);
hold all;
title('Зависимость точечной оценки от номера реализации');
plot(ocenka_max_p,'blue');
plot(x_1,sigmas,'red');
hold off;
figure(3);
hold all
title('Функция правдоподобия');
Y=(1:0.1:10);
for i=1:91
m(i)=func_pr(Y(i));
end
hold all;
plot(Y,m);
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