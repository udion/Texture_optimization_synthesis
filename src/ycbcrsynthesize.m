function [ol11, ol12, ol13, ol21, ol22, ol23, ol31, ol32, ol33, ol33cb, ol33cr, toteng] = ycbcrsynthesize(Isample, r, base, dirname)
%YCBCRSYNTHESIZE Summary of this function goes here
%   Detailed explanation goes here
    pass1patch = 32;
    pass2patch = 16;
    pass3patch = 8;
    
    %%ycbcr transformation
    Isample1 = rgb2ycbcr(Isample);
    IsampleY = Isample1(:,:,1);
    IsampleCb = Isample1(:,:,2);
    IsampleCr = Isample1(:,:,3);
    ol33cb = imresize(IsampleCb, [base*3, base*3]);
    ol33cr = imresize(IsampleCr, [base*3, base*3]);
    
    [Isample_spliced1, cols_in_row1] = splicerVectoriser2d(IsampleY, pass1patch, pass1patch);
    [Isample_spliced2, cols_in_row2] = splicerVectoriser2d(IsampleY, pass2patch, pass2patch);
    [Isample_spliced3, cols_in_row3] = splicerVectoriser2d(IsampleY, pass3patch, pass3patch);
    mkdir(strcat('../output/',dirname));

    %level 1
    display('starting level 1...');
    odim = base;
    numpass = 25;%*lvl
    enarray1 = zeros([1, 3*numpass]);
    Ainit = imresize(IsampleY, [odim, odim]);%rand(odim,odim,3);
    X=Ainit;
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced1,cols_in_row1,pass1patch,r);
        enarray1(i) = en;
    end
    ol11 = X;
    save(strcat('../output/', dirname, '/ol11.mat'), 'ol11');
    save(strcat('../output/', dirname, '/ol11energy.mat'), 'enarray1');
    imshow(ol11,[]);
    display('level 1 pass 1 done.');
    %%%
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced2,cols_in_row2,pass2patch,r);
        enarray1(numpass+i) = en;
    end
    ol12 = X;
    save(strcat('../output/', dirname, '/ol12.mat'), 'ol12');
    save(strcat('../output/', dirname, '/ol12energy.mat'), 'enarray1');
    imshow(ol12,[]);
    display('level 1 pass 2 done.');
    %%%
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced3,cols_in_row3,pass3patch,r);
        enarray1(2*numpass + i) = en;
    end
    ol13 = X;
    save(strcat('../output/', dirname, '/ol13.mat'), 'ol13');
    save(strcat('../output/', dirname, '/ol13energy.mat'), 'enarray1');
    imshow(ol13,[]);
    display('level 1 pass 3 done.');
    
    %level 2
    display('starting level 2...');
    odim = base*2;
    numpass = 25;%*lvl
    enarray2 = zeros([1, 3*numpass]);
    Ainit = imresize(ol13, [odim, odim]);%rand(odim,odim,3);
    X=Ainit;
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced1,cols_in_row1,pass1patch,r);
        enarray2(i) = en;
    end
    ol21 = X;
    save(strcat('../output/', dirname, '/ol21.mat'), 'ol21');
    save(strcat('../output/', dirname, '/ol21energy.mat'), 'enarray2');
    imshow(ol21,[]);
    display('level 2 pass 1 done.');
    %%%
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced2,cols_in_row2,pass2patch,r);
        enarray2(numpass+i) = en;
    end
    ol22 = X;
    save(strcat('../output/', dirname, '/ol22.mat'), 'ol22');
    save(strcat('../output/', dirname, '/ol22energy.mat'), 'enarray2');
    imshow(ol22,[]);
    display('level 2 pass 2 done.');
    %%%
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced3,cols_in_row3,pass3patch,r);
        enarray2(2*numpass + i) = en;
    end
    ol23 = X;
    save(strcat('../output/', dirname, '/ol23.mat'), 'ol23');
    save(strcat('../output/', dirname, '/ol23energy.mat'), 'enarray2');
    imshow(ol23,[]);
    display('level 2 pass 3 done.');
    
    %level 3
    display('level 3 starting...');
    odim = base*3;
    numpass = 25;%*lvl
    enarray3 = zeros([1, 3*numpass]);
    Ainit = imresize(ol23, [odim, odim]);%rand(odim,odim,3);
    X=Ainit;
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced1,cols_in_row1,pass1patch,r);
        enarray3(i) = en;
    end
    ol31 = X;
    save(strcat('../output/', dirname, '/ol31.mat'), 'ol31');
    save(strcat('../output/', dirname, '/ol31energy.mat'), 'enarray3');
    imshow(ol31,[]);
    display('level 3 pass 1 done.');
    %%%
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced2,cols_in_row2,pass2patch,r);
        enarray3(numpass+i) = en;
    end
    ol32 = X;
    save(strcat('../output/', dirname, '/ol32.mat'), 'ol32');
    save(strcat('../output/', dirname, '/ol32energy.mat'), 'enarray3');
    imshow(ol32,[]);
    display('level 3 pass 2 done.');
    %%%
    for i=1:numpass
        [X,~,~,en] = updateE2d(X,Isample_spliced3,cols_in_row3,pass3patch,r);
        enarray3(2*numpass + i) = en;
    end
    ol33 = X;
    save(strcat('../output/', dirname, '/ol33.mat'), 'ol33');
    save(strcat('../output/', dirname, '/ol33energy.mat'), 'enarray3');
    imshow(ol33,[]);
    display('level 3 pass 3 done.');
    %%%
    toteng = [enarray1 enarray2 enarray3];
    save(strcat('../output/', dirname, '/totenergy.mat'), 'toteng');
end