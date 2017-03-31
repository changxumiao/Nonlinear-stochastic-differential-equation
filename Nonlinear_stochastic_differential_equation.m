%file name: test.m
%author: Bill
%date: 2015/11/3
%version: v0.2
%description: 计算随机非线性微分线性方程dx(t)/dt = x - x^3 +
%P(t)，其中P(t)为高斯白噪声，利用欧拉显示格式计算方程。统计数值x的分布，得出概率密度函数，拟合正态分布
%others： None
% function list:
%    1.wgn():产生高斯白噪声，原理不明。
%    2.hist()在max(x)与min(x)间划分n个区间，统计在其中的个数
%history：
%    <author>    <time>    <vision>    <desc>  
%    Bill      2015/11/1   v0.1        建立欧拉差分格式，
%    Bill      2015/11/2   v0.2        计算概率密度
%    Bill      2015/11/25  v0.3        根据文献更改高斯白噪声产生方式
%
clear 

t0 = 100;%时间终点
Nt = 10000;%划分的区间数
deltat = t0/Nt;%计算步长
t = linspace(0,t0,Nt);%时间节点矩阵
D = 0.9;%高斯白噪声强度

num = 50; %进行的次数
x = zeros(num,Nt);%初始化x矩阵
x1 = zeros(num,Nt);%初始化高斯白噪声矩阵
x(:,1) = 0.1;%设定初值

%以下为之前采用wgn函数产生白噪声的方法，
%建立高斯噪声的图像
%figure(1);
% %产生高斯白噪声
% y = wgn(num,Nt,-29.1);%当强度大到一定值时，变成单峰
% plot(t,y)
% title('高斯白噪声');
% xlabel('t');
% ylabel('幅度');

%以下为采用文献中产生高斯白噪声的方法
for i = 1:num;
    for j=1:Nt;
        n1=rand(1);
        n2=rand(1);
        r1=sqrt(-log(n1))*cos(2*pi*n2);
        x1(i,j)=sqrt(2*D*deltat)*r1;
    end
end
%建立高斯噪声的图像
figure(1)
plot (x1)


for j = 1:num;
    %解随机微分方程
    for i = 2:Nt;
        x(j,i) = x(j,i-1) + deltat*(x(j,i-1)-x(j,i-1).^3)+x(j,i-1)*x1(j,i-1)+0.5*x(j,i-1)*x1(j,i-1).^2;  %显示欧拉格式
    end
end

%画出num个x-t图像
figure (2)
for j = 1:num;
    plot(t,x(j,:))
    hold on
end

a = reshape(x,1,num*Nt);%重构数值x矩阵为一个行向量（便于hist函数运算）

Nx = 50;%统计区间划分区间个数，区间划分得越小，则在该区间上x值的密度越小
[c,xi] = hist (a,Nx);%统计区间内数值x的个数c；区间中值xi
%画出概率分布图
figure(3)
plot(xi,c/(num*Nt))%c/(num*Nt)为该区间的密度
print -f -r800 -djpeg distribution
title('x的密度函数');
xlabel('x的取值');
ylabel('密度');