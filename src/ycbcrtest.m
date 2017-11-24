T = imread('../textures/minit4.jpg');
%T = imresize(T,0.5);
T = im2double(T);
T = T(1:32, 1:32,:);
dirname = 'minit4ycbcr';
tic;
clc;
[ol11, ol12, ol13, ol21, ol22, ol23, ol31, ol32, ol33, ol33cb, ol33cr, toteng] = ycbcrsynthesize(T, 0.8, 40, dirname);
toc;

%after above, comment out at first
regen = zeros(120,120,3);
regen(:,:,1) = ol33;
T1 = T(1:30,1:30,:);
T2 = repmat(T1, [4,4]);
T2ycbcr= rgb2ycbcr(T2);
T2cb = imgaussfilt(T2ycbcr(:,:,2),2);
T2cr = imgaussfilt(T2ycbcr(:,:,3),2);
regen(:,:,2) = T2cb;
regen(:,:,3) = T2cr;
regenrgb = ycbcr2rgb(regen);
save(strcat('../output/', dirname,'/ycbcrgen.mat', 'regenrgb'));
imwrite(regenrgb, strcat('../output/', dirname,'/ycbcrgen.jpg'));