function [ol11, ol12, ol13, ol21, ol22, ol23, ol31, ol32, ol33, toteng] = synthesise(Isample, r, base)
%SYNTHESISE takes the sample texture and the level to generate the output
%big image determined by that level, r is the paramenter used in energy
%function number of iterations also depend upon the level, level 1 will be
%of base X base, level 2 will be (base*2) X (base*2) and level 3 image will
%be of (base*3) X (base*3)
    
    %level 1
    display('starting level 1...');
    odim = base;
    numpass = 25;%*lvl
    enarray1 = zeros([1, 3*numpass]);
    Ainit = imresize(Isample, [odim, odim]);%rand(odim,odim,3);
    X=Ainit;
    [Isample_spliced1, cols_in_row1] = splicerVectoriser(Isample, 32,32);
    [Isample_spliced2, cols_in_row2] = splicerVectoriser(Isample, 16,16);
    [Isample_spliced3, cols_in_row3] = splicerVectoriser(Isample, 8,8);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced1,cols_in_row1,32,r);
        enarray1(i) = en;
    end
    display('level 1 pass 1 done.');
    ol11 = X;
    imshow(ol11,[]);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced2,cols_in_row2,16,r);
        enarray1(numpass+i) = en;
    end
    display('level 1 pass 2 done.');
    ol12 = X;
    imshow(ol12,[]);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced3,cols_in_row3,8,r);
        enarray1(2*numpass + i) = en;
    end
    display('level 1 pass 1 done.');
    ol13 = X;
    imshow(ol13,[]);
    
    %level 2
    display('starting level 2...');
    odim = base*2;
    numpass = 25;%*lvl
    enarray2 = zeros([1, 3*numpass]);
    Ainit = imresize(ol13, [odim, odim]);%rand(odim,odim,3);
    X=Ainit;
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced1,cols_in_row1,32,r);
        enarray2(i) = en;
    end
    display('level 2 pass 1 done.');
    ol21 = X;
    imshow(ol21,[]);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced2,cols_in_row2,16,r);
        enarray2(numpass+i) = en;
    end
    display('level 2 pass 2 done.');
    ol22 = X;
    imshow(ol22,[]);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced3,cols_in_row3,8,r);
        enarray2(2*numpass + i) = en;
    end
    display('level 2 pass 3 done.');
    ol23 = X;
    imshow(ol23,[]);
    
    %level 3
    diaplay('level 3 starting...');
    odim = base*3;
    numpass = 25;%*lvl
    enarray3 = zeros([1, 3*numpass]);
    Ainit = imresize(ol23, [odim, odim]);%rand(odim,odim,3);
    X=Ainit;
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced1,cols_in_row1,32,r);
        enarray3(i) = en;
    end
    display('level 3 pass 1 done');
    ol31 = X;
    imshow(ol31,[]);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced2,cols_in_row2,16,r);
        enarray3(numpass+i) = en;
    end
    display('level 3 pass 2 done');
    ol32 = X;
    imshow(ol32,[]);
    for i=1:numpass
        [X,~,~,en] = updateEX(X,Isample_spliced3,cols_in_row3,8,r);
        enarray3(2*numpass + i) = en;
    end
    display('level 3 pass 3 done');
    ol33 = X;
    imshow(ol33,[]);
    
    toteng = [enarray1 enarray2 enarray3];
    
    %saving of all the stuff
    save('../output/ol11.mat', 'ol11');
    save('../output/ol12.mat', 'ol12');
    save('../output/ol13.mat', 'ol13');
    
    save('../output/ol21.mat', 'ol21');
    save('../output/ol22.mat', 'ol22');
    save('../output/ol23.mat', 'ol23');
   
    save('../output/ol31.mat', 'ol31');
    save('../output/ol32.mat', 'ol32');
    save('../output/ol33.mat', 'ol33');
    
    save('../output/totenergy.mat', 'toteng');    
end