function [enP] = calcEnergyPatch(Patch,Isample)
%CALCENERGYPATCH takes a patch from the big image and returns it's
%energy (paper definaition) from the texture sample
[~,~,~,enP] = NNPatchSearch(Patch,Isample);
end

