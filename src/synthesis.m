function [ X,energy,e_idx ] = synthesis(num_iter,patch_size,dim1,sample,X,energy,e_idx )
% synthesis
%   Detailed explanation goes here
% num_iter = 10;
% patch_size = [16,16,3];
% dim1 = [odim(1)*2, odim(2)*2, odim(3)];
X = imresize(X,[dim1(1),dim1(2)]);
[input_patches, KDT] = getNNInfo(patch_size,sample);
NNs = zeros(dim1(1),dim1(2));
step = patch_size(1)/4;
for iter = 1:num_iter
    current_energy = 0;
    for i=1:step:dim1(1)-patch_size(1) +1
        for j=1:step:dim1(2)-patch_size(2)+1
            current = X(i:i+patch_size(1)-1,j:j+patch_size(2)-1,:);
            temp = current(:)'; %needed to seach in the KDT
            NNs(i,j) = knnsearch(KDT,temp);
        end
    end
    X_old = X;
    X = zeros(dim1);
    cnt = zeros(dim1);
    for i=1:step:dim1(1)-patch_size(1) +1
        for j=1:step:dim1(2)-patch_size(2)+1
            match = input_patches(NNs(i,j),:);
            match = reshape(match,patch_size);
            diff = match - X_old(i:i+patch_size(1)-1,j:j+patch_size(2)-1,:);
            diff = sum(diff(:).^2);
            current_energy = current_energy + diff;
            weight = (1E-5 + diff)^(-0.8);
            X(i:i+patch_size(1)-1,j:j+patch_size(2)-1,:) = X(i:i+patch_size(1)-1,j:j+patch_size(2)-1,:)+  match.*weight;
            cnt(i:i+patch_size(1)-1,j:j+patch_size(2)-1,:) = cnt(i:i+patch_size(1)-1,j:j+patch_size(2)-1,:) + weight.*ones(patch_size);
        end
    end
    X = X./cnt;
    energy(e_idx,:) = current_energy/dim1(1);
    e_idx = e_idx + 1;
end

figure;imshow(uint8(X));
imwrite(uint8(X),[num2str(dim1(1)) '_' num2str(dim1(2)) '_' num2str(patch_size(1)) '_' num2str(patch_size(2)) '.jpg']);
end

