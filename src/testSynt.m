T = imread('../textures/miniminit6.jpg');
%T = imresize(T,0.5);
T = im2double(T);
%T = T(1:32, 1:32,:);
tic;
clc;
[ol11, ol12, ol13, ol21, ol22, ol23, ol31, ol32, ol33, toteng] = synthesise(T, 0.8, 40, 'miniminit6');
toc;