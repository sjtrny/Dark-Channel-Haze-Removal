function atmosphere = get_atmosphere(image, dark_channel)

[m, n, ~] = size(image);
n_pixels = m * n;

n_search_pixels = floor(n_pixels * 0.01);

dark_vec = reshape(dark_channel, n_pixels, 1);

image_vec = reshape(image, n_pixels, 3);

[~, indices] = sort(dark_vec, 'descend');

accumulator = zeros(1, 3);

for k = 1 : n_search_pixels
    accumulator = accumulator + image_vec(indices(k),:);
end

atmosphere = accumulator / n_search_pixels;

end