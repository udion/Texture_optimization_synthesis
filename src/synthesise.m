function [oI1, oI2, oI3] = synthesise(Isample, lvl, r)
%SYNTHESISE takes the sample texture and the level to generate the output
%big image determined by that level, r is the paramenter used in energy
%function number of iterations also depend upon the level
    odim = 128*lvl;
    numpass = 100*lvl;
    Ainit = rand(odim,odim,3);
    X=Ainit;
    [Isample_spliced1, cols_in_row1] = splicerVectoriser(Isample, 32,32);
    [Isample_spliced2, cols_in_row2] = splicerVectoriser(Isample, 16,16);
    [Isample_spliced3, cols_in_row3] = splicerVectoriser(Isample, 8,8);
    for i=1:numpass
        [X,~,~] = updateEX(X,Isample_spliced1,cols_in_row1,32,r);
    end
    oI1 = X;
    imshow(oI1,[]);
    for i=1:numpass
        [X,~,~] = updateEX(X,Isample_spliced2,cols_in_row2,16,r);
    end
    oI2 = X;
    imshow(oI2,[]);
    for i=1:numpass
        [X,~,~] = updateEX(X,Isample_spliced3,cols_in_row3,8,r);
    end
    oI3 = X;
    imshow(oI3,[]);
end