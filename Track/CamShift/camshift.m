% ----------------------------------------------------------------------
% - CSE 486
% - Project 5
% - Group 8
% - idg101, adi102, jlm522
% ----------------------------------------------------------------------

clc;
disp('Running...');
close all;
clear;
cd frames;

% ----------------------------------------------------------------------
% Constants
    WHITE = 255;
 
    % Threshold of convergence (in pixels for each deg. of freedom)
	T = 1;
    
    % Number of pixels to expand search window by.
    P = 5;

% ----------------------------------------------------------------------
% Mean Shift

avi = videowriter('output.avi');

% Initial search window size.
%W = [10 10];
W = [80 94];
	
% Initial location of search window.
%L = [95 193];
L = [71 141];

% For plotting motion
Xpoints=[];
Ypoints=[];

disp('Frame: Coordinates');

for frame = 1:99,
	filename = sprintf('%3.3i.png', frame);
	R = imread(filename, 'png');
	
	% Convert image from RGB space to HSV space
	I = rgb2hsv(R);
	
	% Extract the hue information
	I = I(:,:,1);
    I = roicolor(I, 0.83, 1.0);
    
    % Initialization
    oldCamL = [0 0];
    MeanConverging = 1;
% ----------------------------------------------------------------------
    % Create search window box on image.
    for i = L(1) : L(1)+W(1),
        x = i;
        y = L(2);
        if x > size(I,1) | y > size(I,2) | x < 1 | y < 1
            continue;
        else
            R(x, y,:) = 0;
        end
    end
    
    for i = L(1) : L(1)+W(1),
        x = i;
        y = L(2) + W(2);
        if x > size(I,1) | y > size(I,2) | x < 1 | y < 1
            continue;
        else
            R(x, y, :) = 0;
        end
    end    
    
    for i = L(2) : L(2)+W(2),
        x = L(1);
        y = i;
        if x > size(I,1) | y > size(I,2) | x < 1 | y < 1
            continue;
        else
            R(x, y, :) = 0;
        end
    end    

    for i = L(2) : L(2)+W(2),
        x = L(1)+W(1);
        y = i;
        if x > size(I,1) | y > size(I,2) | x < 1 | y < 1
            continue;
        else
            R(x, y, :) = 0;
        end
    end    
% ----------------------------------------------------------------------  
    while MeanConverging,
        % Compute centroid of search window
		M00 = 0.0;
		for i = L(1)-P : (L(1)+W(1)+P),
            for j = L(2)-P : (L(2)+W(2)+P),
                if i > size(I,1) | j > size(I,2) | i < 1 | j < 1
                    continue;
                end
                M00 = M00 + double(I(i,j));
            end
		end
		
		M10 = 0.0;
		for i = L(1)-P : (L(1)+W(1)+P),
            for j = L(2)-P : (L(2)+W(2)+P),
                if i > size(I,1) | j > size(I,2) | i < 1 | j < 1
                    continue;
                end
                M10 = M10 + i * double(I(i,j));
            end
		end
		
		M01 = 0.0;
		for i = L(1)-P : (L(1)+W(1)+P),
            for j = L(2)-P : (L(2)+W(2)+P),
                if i > size(I,1) | j > size(I,2)| i < 1 | j < 1
                    continue;
                end                
                M01 = M01 + j * double(I(i,j));
            end
		end
		
		xc = round(M10 / M00);
		yc = round(M01 / M00);

		oldL = L;
		L = [floor(xc - (W(1)/2)) floor(yc - (W(2)/2))];
       
        % Check threshold
        if abs(oldL(1)-L(1)) < T | abs(oldL(2)-L(2)) < T
            MeanConverging = 0;
        end
    end
    
    % We now know the centroid and M00.
    % This information is used to alter the search window size.
    
    % Adjust window size
    s = round(1.1 * sqrt(M00));
    W = [ s      floor(1.2*s) ];
    L = [floor(xc - (W(1)/2)) floor(yc - (W(2)/2))];
    
    % Output the centroid's coordinates
    disp(sprintf('%3i:   %3i, %3i', frame, xc, yc));
    Xpoints = [Xpoints xc];
    Ypoints = [Ypoints yc];
    
    % Superimpose plus sign on to centroid of hand.
    plus_sign_mask = [0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     1 1 1 1 1 1 1 1 1 1 1 1 1;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0;
                     0 0 0 0 0 0 1 0 0 0 0 0 0];
	sizeM = size(plus_sign_mask);
	for i = -floor(sizeM(1) / 2):floor(sizeM(1) / 2),
        for j = -floor(sizeM(2) / 2):floor(sizeM(2) / 2),
            if plus_sign_mask(i+1+floor(sizeM(1) / 2), j+1+floor(sizeM(2) / 2)) == 1
                R(i+xc, j+yc, :) = WHITE;
            end
        end
	end	
% ----------------------------------------------------------------------
    % Display the probability image.
    I = rgb2hsv(R);
    S = [];
    S(:,:,1) = I(:,:,1);
    S(:,:,2) = I(:,:,1);    
    S(:,:,3) = I(:,:,1);
    
	% Extract the hue information
    avi = addframe(avi, S);
    
end

disp('AVI move parameters:');
avi = close(avi)
% ----------------------------------------------------------------------
plot(Ypoints,Xpoints, 'go' , Ypoints, Xpoints);
axis([0 320 0 240]);


% ----------------------------------------------------------------------
cd ..
disp('Done.');
% ----------------------------------------------------------------------
