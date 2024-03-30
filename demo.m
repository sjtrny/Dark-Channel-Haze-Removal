warning('off','all');

tic;
image = double(imread('forest.jpg'))/255;

image = imresize(image, 0.5);

result = dehaze(image, 0.95, 15);
toc;

figure, imshow(image)
figure, imshow(result)

warning('on','all');