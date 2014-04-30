warning('off','all');

image = double(imread('forest.jpg'))/255;

image = imresize(image, 0.4);

result = dehaze(image, 0.95, 15);

figure, imshow(image)
figure, imshow(result)

warning('on','all');