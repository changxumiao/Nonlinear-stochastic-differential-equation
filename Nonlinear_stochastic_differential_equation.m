%file name: test.m
%author: Bill
%date: 2015/11/3
%version: v0.2
%description: �������������΢�����Է���dx(t)/dt = x - x^3 +
%P(t)������P(t)Ϊ��˹������������ŷ����ʾ��ʽ���㷽�̡�ͳ����ֵx�ķֲ����ó������ܶȺ����������̬�ֲ�
%others�� None
% function list:
%    1.wgn():������˹��������ԭ������
%    2.hist()��max(x)��min(x)�仮��n�����䣬ͳ�������еĸ���
%history��
%    <author>    <time>    <vision>    <desc>  
%    Bill      2015/11/1   v0.1        ����ŷ����ָ�ʽ��
%    Bill      2015/11/2   v0.2        ��������ܶ�
%    Bill      2015/11/25  v0.3        �������׸��ĸ�˹������������ʽ
%
clear 

t0 = 100;%ʱ���յ�
Nt = 10000;%���ֵ�������
deltat = t0/Nt;%���㲽��
t = linspace(0,t0,Nt);%ʱ��ڵ����
D = 0.9;%��˹������ǿ��

num = 50; %���еĴ���
x = zeros(num,Nt);%��ʼ��x����
x1 = zeros(num,Nt);%��ʼ����˹����������
x(:,1) = 0.1;%�趨��ֵ

%����Ϊ֮ǰ����wgn���������������ķ�����
%������˹������ͼ��
%figure(1);
% %������˹������
% y = wgn(num,Nt,-29.1);%��ǿ�ȴ�һ��ֵʱ����ɵ���
% plot(t,y)
% title('��˹������');
% xlabel('t');
% ylabel('����');

%����Ϊ���������в�����˹�������ķ���
for i = 1:num;
    for j=1:Nt;
        n1=rand(1);
        n2=rand(1);
        r1=sqrt(-log(n1))*cos(2*pi*n2);
        x1(i,j)=sqrt(2*D*deltat)*r1;
    end
end
%������˹������ͼ��
figure(1)
plot (x1)


for j = 1:num;
    %�����΢�ַ���
    for i = 2:Nt;
        x(j,i) = x(j,i-1) + deltat*(x(j,i-1)-x(j,i-1).^3)+x(j,i-1)*x1(j,i-1)+0.5*x(j,i-1)*x1(j,i-1).^2;  %��ʾŷ����ʽ
    end
end

%����num��x-tͼ��
figure (2)
for j = 1:num;
    plot(t,x(j,:))
    hold on
end

a = reshape(x,1,num*Nt);%�ع���ֵx����Ϊһ��������������hist�������㣩

Nx = 50;%ͳ�����仮��������������仮�ֵ�ԽС�����ڸ�������xֵ���ܶ�ԽС
[c,xi] = hist (a,Nx);%ͳ����������ֵx�ĸ���c��������ֵxi
%�������ʷֲ�ͼ
figure(3)
plot(xi,c/(num*Nt))%c/(num*Nt)Ϊ��������ܶ�
print -f -r800 -djpeg distribution
title('x���ܶȺ���');
xlabel('x��ȡֵ');
ylabel('�ܶ�');