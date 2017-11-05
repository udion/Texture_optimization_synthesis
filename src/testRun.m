%Test run checking the results of square diff energy after a few pass
numpass = 20;
T = loader('t2.jpg', 50);
A = loader('t2.jpg', 96);
X = A;
for i=1:numpass
    [X,~,~] = updateE(X,T,8);
end