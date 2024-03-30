function atmosphere = get_atmosphere(image, dark_channel)

[m, n, ~] = size(image);
n_pixels = m * n;

n_search_pixels = floor(n_pixels * 0.001);

% Reshape sources
dark_vec = reshape(dark_channel, n_pixels, 1);
image_vec = reshape(image, n_pixels, 3);

% Calculate intensities of brightest pixels in dark channel
% Warning: this is an approximation since averaging RGB may not correspond
% to perceptual intensity. Consider alternatives.
[~, indices] = sort(dark_vec, 'descend');
atmosphere_search_pixels = image_vec(indices(1:n_search_pixels),:);
intensities = mean(atmosphere_search_pixels,2);

% Find the greatest intensity pixels
[~, sorted_intensity_indices] = sort(intensities, 'descend');
max_intensity = intensities(sorted_intensity_indices(1),:);
top_intensity_indices = intensities == max_intensity;

% Get the mean RGB of brightest dark channel pixels
atmosphere = mean(atmosphere_search_pixels(top_intensity_indices,:),1);

end