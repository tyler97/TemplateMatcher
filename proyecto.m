close all
clc

img = imread('Image_3.bmp');
temp = imread('Template.bmp');

img_g = rgb2gray(img);
temp_g = rgb2gray(temp);

[img_H,img_W] = size(img_g);
[temp_H,temp_W] = size(temp_g);



%pos = tlbo(@NCC,200,2,200,img_g,temp_g);
pos = diferencial(@NCC,200,2,100,0.9,0.8,img_g,temp_g);

xp = pos(2,1);
yp = pos(1,1);

figure
hold on

imshow(img)

line([xp xp+temp_W], [yp yp],'Color','g','LineWidth',3);
line([xp xp], [yp yp+temp_H],'Color','g','LineWidth',3);
line([xp+temp_W xp+temp_W], [yp yp+temp_H],'Color','g','LineWidth',3);
line([xp xp+temp_W], [yp+temp_H yp+temp_H],'Color','g','LineWidth',3);