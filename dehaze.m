function [ radiance ] = dehaze( image, omega, win_size, lambda )
%DEHZE Summary of this function goes here
%   Detailed explanation goes here

if ~exist('omega', 'var')
    omega = 0.95;
end

if ~exist('win_size', 'var')
    win_size = 15;
end

if ~exist('lambda', 'var')
    lambda = 0.0001;
end

[m, n, ~] = size(image);

dark_channel = get_dark_channel(image, win_size);

atmosphere = get_atmosphere(image, dark_channel);

trans_est = get_transmission_estimate(image, atmosphere, omega, win_size);

L = get_laplacian(image);

A = L + lambda * speye(size(L));
b = lambda * trans_est(:);

x = A \ b;

transmission = reshape(x, m, n);

radiance = get_radiance(image, transmission, atmosphere);

end

