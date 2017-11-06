function [oImg] = de_splicerVectoriser(P,r,c,s1,s2)
%DE_SPLICERVECTORI Summary of this function goes here
%   Detailed explanation goes here
    A = zeros(s1,s2,2);
    for i=1:s1-r+1
        for j=1:s2-c+1
            A(i:i+r-1, j:j+c-1,1) = A(i:i+r-1,j:j+c-1,1)+reshape(P(:,(i-1)*(s2-c+1)+j), r, c);
            A(i:i+r-1, j:j+c-1, 2) = A(i:i+r-1, j:j+c-1, 2)+1;
        end
    end
    oImg = A(:,:,1)./A(:,:,2);
end

