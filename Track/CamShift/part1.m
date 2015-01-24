% ----------------------------------------------------------------------
% - CSE 486
% - Project 5
% - Group 8
% - idg101, adi102, jlm522
% ----------------------------------------------------------------------

% Part 1

cd frames;

for i = 2:15,
    filename1 = sprintf('%4.4i.bmp', i);
    filename2 = sprintf('%4.4i.bmp', i-1);
    A = imread(filename1, 'bmp');
    A = rgb2gray(A);
    
    B = imread(filename2, 'bmp');
    B = rgb2gray(B);
    
    C = imabsdiff(A,B);
    imwrite(C, sprintf('%4.4i-%4.4i.bmp', i, i-1), 'bmp');
end

cd ..

disp('Done.');