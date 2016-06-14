function [ L ] = get_laplacian( image )
%GET_LAPLACIAN

[m, n, c] = size(image);

img_size = m*n;

win_rad = 1;

epsilon = 0.0000001;

max_num_neigh = (win_rad*2+1)^2;

ind_mat = reshape( 1:img_size, m, n);

indices = 1 : (m*n);

num_ind = length(indices);

max_num_vertex = max_num_neigh * num_ind;

row_inds = zeros( max_num_vertex, 1 );
col_inds = zeros( max_num_vertex, 1 );
vals = zeros( max_num_vertex, 1 );

len = 0;

for k = 1 : length(indices);
    
    ind = indices(k);
    
    [i, j] = ind2sub( [m n], ind );
    
    m_min = max( 1, i - win_rad );
    m_max = min( m, i + win_rad ); 
    n_min = max( 1, j - win_rad );
    n_max = min( n, j + win_rad );
    
    win_inds = ind_mat( m_min : m_max, n_min : n_max );
    win_inds = win_inds(:);
    
    num_neigh = size( win_inds, 1 );
    
    win_image = image( m_min : m_max, n_min : n_max, : );
    win_image = reshape( win_image, num_neigh, c );
    
    win_mean = mean( win_image, 1 );
    
    win_var = inv( (win_image' * win_image / num_neigh) - (win_mean' * win_mean) + (epsilon / num_neigh * eye(c) ) );
    
    win_image = win_image - repmat( win_mean, num_neigh, 1 );
    
    win_vals = ( 1 + win_image * win_var * win_image' ) / num_neigh;
    
    sub_len = num_neigh*num_neigh;
    
    win_inds = repmat(win_inds, 1, num_neigh);
    
    row_inds(1+len: len+sub_len) = win_inds(:);
    
    win_inds = win_inds';
    
    col_inds(1+len: len+sub_len) = win_inds(:);
    
    vals(1+len: len+sub_len) = win_vals(:);
    
    len = len + sub_len;
    
end

A = sparse(row_inds(1:len),col_inds(1:len),vals(1:len),img_size,img_size);

D = spdiags(sum(A,2),0,n*m,n*m);

L = D - A;

end

