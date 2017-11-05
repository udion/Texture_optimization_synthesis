function [totEn] = calcEnergy(iI, Isample, w)
%CALCENERGY takes the current big image and the texture sample and gives
%the total energy, w is the width/height of patches to be considered
    sz1 = size(iI);
    n = sz1(1);
    cmax = n-(w-1);
    rmax = n-(w-1);
    totEn = 0;
    for i=1:w/4:rmax
        for j=1:w/4:cmax
            Patch = iI(i:i+w-1, j:j+w-1, :);
            enP = calcEnergyPatch(Patch, Isample);
            totEn = totEn + enP;
        end
    end
end

