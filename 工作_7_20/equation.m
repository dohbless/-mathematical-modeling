function F=equation(x)
load matlab.mat
F=[r(1)^2==(radio(1,1)-x(1))^2+(radio(1,2)-x(2))^2+(radio(1,3)-x(3))^2;
    r(2)^2==(radio(2,1)-x(1))^2+(radio(2,2)-x(2))^2+(radio(2,3)-x(3))^2;
    r(3)^2==(radio(3,1)-x(1))^2+(radio(3,2)-x(2))^2+(radio(3,3)-x(3))^2];
end