function trans_est = get_transmission_estimate(image, atmosphere, omega, win_size)

[m, n, ~] = size(image);

rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);

trans_est = 1 - omega * get_dark_channel( image ./ rep_atmosphere, win_size);

end