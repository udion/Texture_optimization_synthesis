function [oI] = loader(fname, n)
%LOADER returns the image in textures folder resized as a nXn square
oI = imread(strcat('../textures/', fname));
oI = imresize(im2double(oI),[n,n]);
end