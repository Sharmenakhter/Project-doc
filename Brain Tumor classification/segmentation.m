I = imread('two.png');
imshow(I)

greyImage = rgb2gray(I);
figure,imshow(greyImage);

histImage = histeq(greyImage);
figure, imshow(histImage);





