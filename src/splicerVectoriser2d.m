function [ov, cols_in_row] = splicerVectoriser2d(iImg, r, c)
%SPLICERVECTORISER2D Summary of this function goes here
%   Detailed explanation goes here
    sz = size(iImg);
    ov = zeros(r*c*1, (sz(1)-r+1)*(sz(2)-c+1));
    cols_in_row = sz(2)-c+1;
    for i=1:sz(1)-r+1
        for j=1:sz(2)-c+1          
            windw = iImg(i:i+r-1, j:j+c-1);
            ov(:,(i-1)*(sz(2)-c+1)+j) = windw(:);
        end
    end
end

