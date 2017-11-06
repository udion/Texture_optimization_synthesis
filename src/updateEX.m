function [Xnext, X1_, X2_] = updateEX(Xcurr, Isample_spliced, cols_in_row, w, r)
%UPDATEE It takes the current big picture and updates it in such a manner
%that the energy after update is minimised, at pixels where multiple values
%were possible it takes the average
    sz1 = size(Xcurr);
    n = sz1(1);
    cmax = n-(w-1);
    rmax = n-(w-1);
    Tens = zeros(n,n,3,2);
    for i=1:w/4:rmax
        for j=1:w/4:cmax
            Patch = Xcurr(i:i+w-1, j:j+w-1, :);
            %optimised
            [simP, ~, ~, ~] = NNPatchSearchX(Patch, Isample_spliced, cols_in_row, r);
            %
            Tens(i:i+w-1, j:j+w-1, :, 1) = Tens(i:i+w-1, j:j+w-1, :, 1)+simP;
            Tens(i:i+w-1, j:j+w-1, :, 2) = Tens(i:i+w-1, j:j+w-1, :, 2)+1;
        end
    end
    Xnext = Tens(:,:,:,1)./Tens(:,:,:,2);
    X1_ = Tens(:,:,:,1);
    X2_ = Tens(:,:,:,2);
end