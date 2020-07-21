%% 飞行器的多基雷达定位
% 首先准备两组雷达站准确值及飞行器坐标,计算得到距飞行器真实距离
% 再将这几组雷达真实坐标及其距飞行器距离加入高斯白噪声来模拟真实情况下的测量数据
% 并以此建立无约束非线性规划模型来求解飞行物坐标,并与飞行物真实坐标进行比较
% 其中在求解规划模型里，采用了LargeScale寻优函数
clear;clc
format long g 
load matlab.mat
s=[25,25,25] %预设飞行器真实坐标
r(1)=sqrt((radio(1,1)-s(1))^2+(radio(1,2)-s(2))^2+(radio(1,3)-s(3))^2);
r(2)=sqrt((radio(2,1)-s(1))^2+(radio(2,2)-s(2))^2+(radio(2,3)-s(3))^2);
r(3)=sqrt((radio(3,1)-s(1))^2+(radio(3,2)-s(2))^2+(radio(3,3)-s(3))^2);
disp('求得第一组雷达站距飞行器真实距离为：'); disp(r(1:3,:))
r(4)=sqrt((radio(4,1)-s(1))^2+(radio(4,2)-s(2))^2+(radio(4,3)-s(3))^2);
r(5)=sqrt((radio(5,1)-s(1))^2+(radio(5,2)-s(2))^2+(radio(5,3)-s(3))^2);
r(6)=sqrt((radio(6,1)-s(1))^2+(radio(6,2)-s(2))^2+(radio(6,3)-s(3))^2);
disp('求得第二组雷达站距飞行器真实距离为：'); disp(r(4:6,:))
plot3(s(1),s(2),s(3),'ro',radio(1,1),radio(1,2),radio(1,3),'bo',radio(2,1),radio(2,2),radio(2,3),'b*',radio(3,1),radio(3,2),radio(3,3),'b+',radio(4,1),radio(4,2),radio(4,3),'go',radio(5,1),radio(5,2),radio(5,3),'g*',radio(6,1),radio(6,2),radio(6,3),'g+')
legend('飞行器真实坐标','雷达站组坐标1-1','雷达站组坐标1-2','雷达站组坐标1-3','雷达站组坐标2-1','雷达站组坐标2-2','雷达站组坐标2-3')

%% 加了5%信噪比高斯白噪声的测量数据
figure(2)
r_noise=awgn(r,10*log10(0.05))
radio_noise=awgn(radio,10*log10(0.05))
plot3(radio_noise(:,1),radio_noise(:,2),radio_noise(:,3),'r*',radio(:,1),radio(:,2),radio(:,3),'bo')
legend('加噪声后雷达站坐标','原雷达站坐标')
% 使用蒙特卡罗的方法来找初始值(推荐）
n=10000000; %生成的随机数组数
x1=unifrnd(-100,100,n,1);  % 生成在[-100,100]之间均匀分布的随机数组成的n行1列的向量构成x1
x2=unifrnd(-100,100,n,1);  % 生成在[-100,100]之间均匀分布的随机数组成的n行1列的向量构成x2
x3=unifrnd(-100,100,n,1);  % 生成在[-100,100]之间均匀分布的随机数组成的n行1列的向量构成x3
fmin=+inf; % 初始化函数f的最小值为正无穷（后续只要找到一个比它小的我们就对其更新）
for i=1:n
    x = [x1(i), x2(i),x3(i)];  %构造x向量
     % 判断是否满足条件
     error_1=r_noise(1)-sqrt((x(1)-radio_noise(1,1))^2+(x(2)-radio_noise(1,2))^2+(x(3)-radio_noise(1,3))^2);
     error_2=r_noise(2)-sqrt((x(1)-radio_noise(2,1))^2+(x(2)-radio_noise(2,2))^2+(x(3)-radio_noise(2,3))^2);
     error_3=r_noise(3)-sqrt((x(1)-radio_noise(3,1))^2+(x(2)-radio_noise(3,2))^2+(x(3)-radio_noise(3,3))^2);
     result=error_1^2+error_2^2+error_3^2;
     % 如果满足条件就计算函数值
        if  result  < fmin  % 如果这个函数值小于我们之前计算出来的最小值
            fmin = result;  % 那么就更新这个函数值为新的最小值
            x0 = x;  % 并且将此时的x1 x2 x3更新新为初始值
        end
end
disp('蒙特卡罗选取的初始值为：'); disp(x0)
%% 对寻优函数搜索方式的设定 ，LargeScale指大规模搜索，off表示在规模搜索模式关闭
 options = optimset('LargeScale','off');
 optimset('Display','off')
[x,fval,exitflag ] = fminunc('position_radio',x0,options)
disp('无约束非线性规划求得第一组飞行器坐标为：'); disp(x)
[x1,fval,exitflag ] = fminunc('position_radio2',x0,options)
disp('无约束非线性规划求得第二组飞行器坐标为：'); disp(x1)
figure(3)
plot3(s(1),s(2),s(3),'ro',x(1),x(2),x(3),'bo',x1(1),x1(2),x1(3),'b*')
legend('飞行器真实坐标','第一组雷达站求得飞行器坐标','第二组雷达站求得飞行器坐标')


