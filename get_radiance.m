function radiance = get_radiance(image, transmission, atmosphere)

[m, n, ~] = size(image);

rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);

max_transmission = repmat(max(transmission, 0.1), [1, 1, 3]);

radiance = ((image - rep_atmosphere) ./ max_transmission) + rep_atmosphere;

end