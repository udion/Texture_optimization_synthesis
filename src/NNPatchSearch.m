function [simPatch, wx, wy, energy] = NNPatchSearch(Patch, Isample, r)
%NNPATCHSEARCH Patch is a square box from large image, Isample
% is the texture sample, this returns the most similar patch from the texture
    sz = size(Patch);
    n = sz(1);
    [p, q, ~] = size(Isample);
    cmax = q-(n-1);
    rmax = p-(n-1);
    
    mindist = Inf;
    for i=1:rmax
        for j=1:cmax
            window = Isample(i:i+n-1, j:j+n-1,:);
            diff_ = abs((Patch-window)).^r;
            en = sum(diff_(:));
            if en<mindist
                mindist = en;
                wx = j;
                wy = i;
                simPatch = window;
                energy = en;
            end
        end
    end
end