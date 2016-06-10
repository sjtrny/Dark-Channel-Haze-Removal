warning('off','all');

tic;
image = double(imread('forest.jpg'))/255;

image = imresize(image, 0.4);

result = dehaze_fast(image, 0.95, 5);
toc;

figure, imshow(image)
figure, imshow(result)

warning('on','all');