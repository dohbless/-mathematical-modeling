%% �������Ķ���״ﶨλ
% ����׼�������״�վ׼ȷֵ������������,����õ����������ʵ����
% �ٽ��⼸���״���ʵ���꼰����������������˹��������ģ����ʵ����µĲ�������
% ���Դ˽�����Լ�������Թ滮ģ����������������,�����������ʵ������бȽ�
% ���������滮ģ���������LargeScaleѰ�ź���
clear;clc
format long g 
load matlab.mat
s=[25,25,25] %Ԥ���������ʵ����
r(1)=sqrt((radio(1,1)-s(1))^2+(radio(1,2)-s(2))^2+(radio(1,3)-s(3))^2);
r(2)=sqrt((radio(2,1)-s(1))^2+(radio(2,2)-s(2))^2+(radio(2,3)-s(3))^2);
r(3)=sqrt((radio(3,1)-s(1))^2+(radio(3,2)-s(2))^2+(radio(3,3)-s(3))^2);
disp('��õ�һ���״�վ���������ʵ����Ϊ��'); disp(r(1:3,:))
r(4)=sqrt((radio(4,1)-s(1))^2+(radio(4,2)-s(2))^2+(radio(4,3)-s(3))^2);
r(5)=sqrt((radio(5,1)-s(1))^2+(radio(5,2)-s(2))^2+(radio(5,3)-s(3))^2);
r(6)=sqrt((radio(6,1)-s(1))^2+(radio(6,2)-s(2))^2+(radio(6,3)-s(3))^2);
disp('��õڶ����״�վ���������ʵ����Ϊ��'); disp(r(4:6,:))
plot3(s(1),s(2),s(3),'ro',radio(1,1),radio(1,2),radio(1,3),'bo',radio(2,1),radio(2,2),radio(2,3),'b*',radio(3,1),radio(3,2),radio(3,3),'b+',radio(4,1),radio(4,2),radio(4,3),'go',radio(5,1),radio(5,2),radio(5,3),'g*',radio(6,1),radio(6,2),radio(6,3),'g+')
legend('��������ʵ����','�״�վ������1-1','�״�վ������1-2','�״�վ������1-3','�״�վ������2-1','�״�վ������2-2','�״�վ������2-3')

%% ����5%����ȸ�˹�������Ĳ�������
figure(2)
r_noise=awgn(r,10*log10(0.05))
radio_noise=awgn(radio,10*log10(0.05))
plot3(radio_noise(:,1),radio_noise(:,2),radio_noise(:,3),'r*',radio(:,1),radio(:,2),radio(:,3),'bo')
legend('���������״�վ����','ԭ�״�վ����')
% ʹ�����ؿ��޵ķ������ҳ�ʼֵ(�Ƽ���
n=10000000; %���ɵ����������
x1=unifrnd(-100,100,n,1);  % ������[-100,100]֮����ȷֲ����������ɵ�n��1�е���������x1
x2=unifrnd(-100,100,n,1);  % ������[-100,100]֮����ȷֲ����������ɵ�n��1�е���������x2
x3=unifrnd(-100,100,n,1);  % ������[-100,100]֮����ȷֲ����������ɵ�n��1�е���������x3
fmin=+inf; % ��ʼ������f����СֵΪ���������ֻҪ�ҵ�һ������С�����ǾͶ�����£�
for i=1:n
    x = [x1(i), x2(i),x3(i)];  %����x����
     % �ж��Ƿ���������
     error_1=r_noise(1)-sqrt((x(1)-radio_noise(1,1))^2+(x(2)-radio_noise(1,2))^2+(x(3)-radio_noise(1,3))^2);
     error_2=r_noise(2)-sqrt((x(1)-radio_noise(2,1))^2+(x(2)-radio_noise(2,2))^2+(x(3)-radio_noise(2,3))^2);
     error_3=r_noise(3)-sqrt((x(1)-radio_noise(3,1))^2+(x(2)-radio_noise(3,2))^2+(x(3)-radio_noise(3,3))^2);
     result=error_1^2+error_2^2+error_3^2;
     % ������������ͼ��㺯��ֵ
        if  result  < fmin  % ����������ֵС������֮ǰ�����������Сֵ
            fmin = result;  % ��ô�͸����������ֵΪ�µ���Сֵ
            x0 = x;  % ���ҽ���ʱ��x1 x2 x3������Ϊ��ʼֵ
        end
end
disp('���ؿ���ѡȡ�ĳ�ʼֵΪ��'); disp(x0)
%% ��Ѱ�ź���������ʽ���趨 ��LargeScaleָ���ģ������off��ʾ�ڹ�ģ����ģʽ�ر�
 options = optimset('LargeScale','off');
 optimset('Display','off')
[x,fval,exitflag ] = fminunc('position_radio',x0,options)
disp('��Լ�������Թ滮��õ�һ�����������Ϊ��'); disp(x)
[x1,fval,exitflag ] = fminunc('position_radio2',x0,options)
disp('��Լ�������Թ滮��õڶ������������Ϊ��'); disp(x1)
figure(3)
plot3(s(1),s(2),s(3),'ro',x(1),x(2),x(3),'bo',x1(1),x1(2),x1(3),'b*')
legend('��������ʵ����','��һ���״�վ��÷���������','�ڶ����״�վ��÷���������')


