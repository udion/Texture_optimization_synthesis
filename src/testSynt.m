T = imread('../textures/minit4.jpg');
%T = imresize(T,0.5);
T = im2double(T);
[o1, o2, o3] = synthesise(T,1,0.8);