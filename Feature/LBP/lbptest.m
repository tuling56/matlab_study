%% 参考博文：http://blog.csdn.net/kuaitoukid/article/details/8643253

%%%%%%%%%%%%%%%%%%%LBP变换后的图像%%%%%%%%%%%%%%%%%%
I11 = imread('test1.png');
I11 =rgb2gray(I11);
SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
I12=LBP(I11,SP,0,'i');



I21 = imread('test2.png');
I21 =rgb2gray(I21);
SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
I22=LBP(I21,SP,0,'i');

re1 = abs(I22-I12);

% re1 = 255 - re1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I31 = imread('test3.png');
I31 =rgb2gray(I31);
SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
I32=LBP(I31,SP,0,'i');


I41 = imread('test4.png');
I41 =rgb2gray(I41);
SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
I42=LBP(I41,SP,0,'i');


re2 = abs(I32-I42);
% re2 = 255 - re2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
re3 = abs(I32 - I12);
% re3 = 255 - abs(I32 - I12);
re4 = abs(I32 - I22);
re5 = abs(I42 - I12);
re6 = abs(I42 - I22);


%%%%%%%%%%%%%%%%%%%%%%直方图%%%%%%%%%%%%%%%%%%%%%%%%
mapping=getmapping(8,'u2');
H11=LBP(I11,1,8,mapping,'h'); %LBP histogram in (8,1) neighborhood using uniform patterns
subplot(2,2,1),stem(H11);
H12=LBP(I11);
subplot(2,2,2),stem(H12);


H21=LBP(I21,1,8,mapping,'h'); %LBP histogram in (8,1) neighborhood using uniform patterns
subplot(2,2,3),stem(H21);
H22=LBP(I21);
subplot(2,2,4),stem(H22);


H31=LBP(I31,1,8,mapping,'h'); %LBP histogram in (8,1) neighborhood using uniform patterns
subplot(2,2,3),stem(H31);
H32=LBP(I31);
subplot(2,2,4),stem(H32);


%%%%%%%%%%%%%%%%%%%%%%%无聊瞎写%%%%%%%%%%%%%%%%%%%%%%%%
[row, col] = size(I11);
It1 = ones(row, col);
for i = 2 : col
    It1(:, i - 1) = abs(I11(:, i) - I11(:, i - 1));
end


It2 = ones(row, col);
for i = 2 : row
    It2(i-1,:) = abs(I11(i,:) - I11(i-1,:));
end