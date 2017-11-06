%Test run checking the results of square diff energy after a few pass
numpass = 20;
T = loader('smallt4.jpg', 50);
%optimised
[T_spliced,cols_in_row] = splicerVectoriser(T,24,24);
%
A = loader('smallt4.jpg', 96);
X = A;
for i=1:numpass
    %[X,~,~] = updateE(X,T,24,0.8);
    [X,~,~] = updateEX(X,T_spliced,cols_in_row,24,0.8);
end