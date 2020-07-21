%% 最小残差平方和损失函数
% 初始设置三组雷达数据及其距离
function f=position_radio2(x)
load matlab.mat
error_1=r_noise(4)-sqrt((x(1)-radio_noise(4,1))^2+(x(2)-radio_noise(4,2))^2+(x(3)-radio_noise(4,3))^2);
error_2=r_noise(5)-sqrt((x(1)-radio_noise(5,1))^2+(x(2)-radio_noise(5,2))^2+(x(3)-radio_noise(5,3))^2);
error_3=r_noise(6)-sqrt((x(1)-radio_noise(6,1))^2+(x(2)-radio_noise(6,2))^2+(x(3)-radio_noise(6,3))^2);
f=error_1^2+error_2^2+error_3^2;
end