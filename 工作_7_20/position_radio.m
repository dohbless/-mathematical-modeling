%% 最小残差平方和损失函数
% 初始设置三组雷达数据及其距离
function f=position_radio(x)
load matlab.mat
error_1=r_noise(1)-sqrt((x(1)-radio_noise(1,1))^2+(x(2)-radio_noise(1,2))^2+(x(3)-radio_noise(1,3))^2);
error_2=r_noise(2)-sqrt((x(1)-radio_noise(2,1))^2+(x(2)-radio_noise(2,2))^2+(x(3)-radio_noise(2,3))^2);
error_3=r_noise(3)-sqrt((x(1)-radio_noise(3,1))^2+(x(2)-radio_noise(3,2))^2+(x(3)-radio_noise(3,3))^2);
f=error_1^2+error_2^2+error_3^2;
end

