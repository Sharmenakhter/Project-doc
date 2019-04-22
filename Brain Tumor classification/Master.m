function featureVector = Master(im,handles)
%im=imread('img.jpg');
fim=mat2gray(im);
level=graythresh(fim);
bwfim=im2bw(fim,0.1);
[bwfim0,level0]=fcmthresh(fim,0);
[bwfim1,level1]=fcmthresh(fim,1);
figure(1);
subplot(2,2,1);
imshow(fim);title('Original');
subplot(2,2,2);
imshow(bwfim);title(sprintf('Otsu,level=%f',level));
subplot(2,2,3);
imshow(bwfim0);title(sprintf('FCM0,level=%f',level0));
subplot(2,2,4);
imshow(bwfim1);title(sprintf('FCM1,level=%f',level1));
% imwrite(bwfim1,'fliver6.jpg');
%...features......

numOfTumorRegion = bwconncomp(bwfim1, 4);
%numOfTumorRegion.NumObjects
glcms = graycomatrix(bwfim1);
energy = sum(sum(glcms.^2));
entrophy = (-1)*(sum(sum(dot(log(glcms),glcms))));
glcms = reshape(glcms,4,1);

areaOfTumor = sum(sum(bwfim1));
%...... features...

featureVector = [ numOfTumorRegion.NumObjects ; energy; entrophy; glcms; areaOfTumor ]';
end