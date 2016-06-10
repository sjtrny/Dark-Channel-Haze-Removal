function [ radiance ] = dehaze_fast( image, omega, win_size )
%DEHZE Summary of this function goes here
%   Detailed explanation goes here

if ~exist('omega', 'var')
    omega = 0.95;
end

if ~exist('win_size', 'var')
    win_size = 15;
end

r = 15;
res = 0.001;

[m, n, ~] = size(image);

dark_channel = get_dark_channel(image, win_size);

atmosphere = get_atmosphere(image, dark_channel);

trans_est = get_transmission_estimate(image, atmosphere, omega, win_size);

x = guided_filter(rgb2gray(image), trans_est, r, res);

transmission = reshape(x, m, n);

radiance = get_radiance(image, transmission, atmosphere);

end

