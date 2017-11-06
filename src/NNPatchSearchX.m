function [simPatch, wx, wy, energy] = NNPatchSearchX(Patch, Isample_spliced, cols_in_row, r)
%NNPATCHSEARCHX is the faster version of NNPatchSearch which avoids the for
%loop it requires that the testure sample patches be already vectorised and
%stacked together in form of a matrix which is formed in row major fashion
    sz1 = size(Patch);
    sz2 = size(Isample_spliced);
    patch_vec = Patch(:);
    patch_vecmat = repmat(patch_vec,[1,sz2(2)]);
    
    diff_ = (abs(Isample_spliced - patch_vecmat)).^r;
    energies = sum(diff_);
    [energy, indx] = min(energies);
    
    wy = indx/cols_in_row;
    wx = mod(indx, cols_in_row);
    sp = Isample_spliced(:, indx);
    simPatch = reshape(sp, sz1);
end
