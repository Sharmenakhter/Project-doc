function [bwfim,fim,level] = imageProcessing(im, handles)
%im=imread('img.jpg');
fim=mat2gray(im);
level=graythresh(fim);
bwfim=im2bw(fim,0.1);
set(handles.axes1);
imshow(bwfim);
end