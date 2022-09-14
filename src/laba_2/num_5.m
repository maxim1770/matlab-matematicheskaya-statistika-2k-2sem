clear
clc
%-----1----—
N=10000;
A=2;
B=3;
TETTA=1;
X = random('Gamma',A,B,N,1); % генерируем выборку

%-----2---—
%-----2.1--— метод моментов
M=1000;
NN=10;
for i=1:M
xx1=random('Gamma',A,B,NN,1); % 1000 выборочных реализаций объема N
as(i)=A; % точное значение параметра
bs(i)=B; % точное значение параметра
a(i)=mean(xx1)/B;
b(i)=mean(xx1)/A;
x_1(i)=i;
end
%графики
figure(1);
subplot(2,1,1);
hold all;
plot(a,'blue');
plot(x_1,as,'red');
subplot(2,1,2);
hold all;
plot(b,'black');
plot(x_1,bs,'green');
%----2.2--— метод максимального правдоподобия
for i=1:M
X2_2=random('Gamma',A,B,NN,1);
s1=0;
s2=0;
for j=1:NN
s1=s1+log(X2_2(j)/TETTA);
s2=s2+log((X2_2(j)/TETTA).^B);
end
func= @(NN,s1,s2,a,b,TETTA) NN(log(abs(b)/TETTA)-log(gamma(a/b))+(a-1)/NN*s1-s2/NN); %логарифм от функции правдоподбия
func_pr= @(NN,s1,s2,a,b,TETTA) sum(func(NN,s1,s2,a,b,TETTA)); %логарифм от функции правдоподбия для всей выборки
func_pr2=@(NN,s1,s2,a,b,TETTA) -func_pr(NN,s1,s2,a,b,TETTA); %переворачиваем функцию и находим минимум
ocenka_max_p(i)=fminbnd(func_pr2,0,10);
end
figure(2);
hold all;
title('Зависимость точечной оценки от номера реализации');
plot(ocenka_max_p,'blue');
plot(x_1,bs,'red');
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
sum_ocenka_a=sum(a)/NN;
smesh_ocenka=sum_ocenka_a-A;
disp=sum((a-sum_ocenka_a).^2)/NN;
rass=sum((a-A).^2)/NN;
%----3---—
figure(4);
hold all;
N1=10000;
X_max=max(X);
X_min=min(X);
r=floor(log2(N1))+1;%флор - целая часть r- количество столбцов
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
bu=mean(X);
end
sumb=sum(bu);
title('Гистограмма и плотность вероятности')
f=pdf('Gamma',xx,A,B);
f1=pdf('Gamma',xx,sumb,B);
hold on
plot(xx,f,'red');
plot(xx,f1,'green')
%----4---—
figure(5);
hold all;
F_teor = cdf ('Gamma',xx,A,B);
F_teor_1=cdf('Gamma',xx,sumb,B);
plot(xx,F_teor,'green');
plot(xx,F_teor_1,'blue');
ecdf(X);% "Эмпирическая по негруппированным
