function [output] = Avi2Movie(filename,option,option2,option3)
%--------------------------------------------------------------------
% result = Avi2Movie (filename, 
%                     number of frames to process, 
%                     first frame to use, 
%                     last frame to use)
%
% Result = read Frames as MatLab MOVIE-format:
%
% Example: Avi2Mivie('sample.avi',30,10,12)
%            reads and processes the first 30 frames of the file 
%            'sample.avi', and store frame 10, 11 and 12 as 
%            one MatLab Movie-Dataset.       
%
% NOTE: supports only uncompressed plain avi(RIFF) files 
%       (8, 16, 24, 32 Bit per Pixel)
%
% (c) by Rainer Rawer (using Matlab 5.3)
% http://www.rawer.de/rainer/software/
% rrawer@gmx.de
% 22/12/2000 
%--------------------------------------------------------------------


% default declarations:
JUNK         = [74 85 78 75];				% <JUNK>
RIFF			 = [82 73 70 70]; 			% <RIFF>
AVI          = [65 86 73 32];				% <AVI >
MOVI         = [109 111 118 105];		% <movi>
ValidFrameID = [48 48 100 98];			% <00db>
AVIH         = [97 118 105 104];			% <avih>
STRF         = [115 116 114 102];		% <strf>
version      = '1.0';
lines        = 240;  % default lines per frame
columns      = 320;  % default colons per frame
bytes        = 1;    % default bytes per pixel
no_of_frames = 1;    % no of frames to read
contador=0;
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
% checking if files is existing and a valid RIFF/AVI file
%-------------------------------------------------------------------------

  if nargin == 0; 
     disp(['-------------------------------']);  
     disp([' Avi2Movie V',version, '  by R.Rawer `99-`01'])
     disp(['-------------------------------']);
     disp([' usage: Avi2Movie(filename,'])
     disp(['                  number of frames to process,'])
     disp(['                  first frame to use,'])
     disp(['                  last frame to use)']) 
     error(['### no parameters']); 
  end
  if nargin < 4; option3=option2 ; end
  if nargin < 3; option2 = 0, option3= 0 ; end
  if nargin < 2; option = 0; option2 = 0, option3= 0 ; end
  
  
  
  fid = fopen(filename, 'r');
  if fid < 3; error(['### Avi2Movie: ', filename, ' NOT found.']); end
  
  xx = uint8(fread(fid, 5000, 'uint8'));  
  if max(xx(1:4)'==RIFF==0);										%check for: 'RIFF'
     error(['### Avi2Movie: ', filename, ...
           ' is not a valid RIFF file.']); 
  elseif max(xx(9:12)'==AVI==0);									%check for: 'AVI '
          error(['### Avi2Movie: ', filename, ...
                ' is not a valid AVI file.']); 
  end        
  fclose(fid);
  
  
%-------------------------------------------------------------------------
% Extracting AVI header information
%-------------------------------------------------------------------------

h=1;i=0;h2=0;e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'== AVIH); 									%check for ID: 'avih'
      h2=h;
      e=0;
   end 		 
end
time_per_frame = double(xx(h2+8))+double(xx(h2+9))*256+double(xx(h2+10))*256*256+double(xx(h2+11))*256*256*256;
no_of_frames   = double(xx(h2+24))+double(xx(h2+25))*256+double(xx(h2+26))*256*256+double(xx(h2+27))*256*256*256;
columns        = double(xx(h2+40))+double(xx(h2+41))*256+double(xx(h2+42))*256*256+double(xx(h2+43))*256*256*256;
lines          = double(xx(h2+44))+double(xx(h2+45))*256+double(xx(h2+46))*256*256+double(xx(h2+47))*256*256*256;

i=0;h3=0;e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==STRF); 									%check for ID: 'strf'
      h3=h;
      e=0;
   end 		 
end
color_depth=double(xx(h3+22))+double(xx(h3+23))*256;
switch color_depth
   case 8
      bytes=1;
   case 16
      bytes=2;
   case 24 
      bytes=3;
   otherwise bytes=4;
end

e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==MOVI); 									%check for ID: 'movi'
      e=0; 
      h1=h; 
   end 		
end
frame_length=double(xx(h1+8))+double(xx(h1+9))*256+double(xx(h1+10))*256*256+double(xx(h1+11))*256*256*256;
frame_ID=xx(h1+4:h1+7);

% re-open file to check foer actual framelength:
fid = fopen(filename, 'r');
if fid < 3; error(['### Avi2Movie: ', filename, ' NOT found.']); end
% seek to place where 2nd frame should be:
fseek(fid,h1+4+frame_length,-1);
xx = uint8(fread(fid, 5000, 'uint8'));  
h=0;i=0;h5=0;e=1;
while e==1;
   h=h+1;
   if min(xx(h:(h+3))'==frame_ID'); 							%check for ID: frame_ID
      h5=h;
      e=0;
   end 		 
end
frame_offset=h5;

% check for compressed AVIs:
if ((lines*columns)~=(frame_length/bytes));
   error('### no compressed AVI supported !');
end;   


% check if fra,mes to read exeeds number of frames in file:
if (option > no_of_frames)
   option = no_of_frames;
   disp(sprintf('Warning: No of frames to read adjusted to %d!',option));   
end;

   
%display header information:
frame_ID=double(frame_ID);
disp('---------------------------------------------------------');
disp(['Avi2Movie V',version,' by R.Rawer `99']);
disp(sprintf('   filename                 : "%s"',filename));
disp(sprintf('   number of frames to read : %d',option));
disp(sprintf('   display frame            : #%d to #%d',option2,option3));
disp('---------------------------------------------------------');
disp(sprintf('   number of data blocks : %d',no_of_frames));
disp(sprintf('   frames per second     : %5.2f',1000000*1/time_per_frame));
disp(sprintf('   frame size            : %d x %d',columns,lines));
disp(sprintf('   colour depth          : %d (%dbyte)',color_depth,bytes));
disp(sprintf('   frame length          : %d (0x%x)',frame_length,frame_length));
disp(sprintf('   frame ID              : %c%c%c%c',frame_ID(1),frame_ID(2),frame_ID(3),frame_ID(4)));
disp(sprintf('   frame offset          : %d',frame_offset));
disp('---------------------------------------------------------');



%-------------------------------------------------------------------------
% start reading single frames
%-------------------------------------------------------------------------

% re-open file for actual reading of data:
fid = fopen(filename, 'r');
if fid < 3; error(['### Avi2Movie: ', filename, ' NOT found.']); end
fseek(fid,h1+3,-1);

% read frames
frames=0;
if option>0; no_of_frames=option;end
while (i<no_of_frames);
   frames=frames+1;
   i=i+1;
   %disp(sprintf('processing frame %d of %d ',i,no_of_frames));
   
   frame_header = uint8(fread(fid, 8, 'uint8')');
   f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;
   
   % seek for next valid pixture dataset:
   e=0;
   while e==0;
      if (frame_header(1:4)==JUNK );
         %found a JUNK frame and skipping it...
         %disp('reading JUNK frame...');
         xx=uint8(fread(fid, f_length, 'uint8')');
         frame_header = uint8(fread(fid, 8, 'uint8')');
         f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;
      elseif f_length==0;
         %found empty frame and skipping it...
         %disp('reading empty frame...');
         frame_header = uint8(fread(fid, 8, 'uint8')');
         i=i+1;
         f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;
      elseif (frame_header(1:4)== frame_ID')
         %found valid frame....
         %disp('found valid movi-frame...');
         e=1;
      else   
         %found non-movi media frame
         %disp('skipping non-movi frame...');
         %disp('flength');f_length
         xx=uint8(fread(fid, f_length, 'uint8')');
         frame_header = uint8(fread(fid, 8, 'uint8')');
         f_length=double(frame_header(5))+double(frame_header(6))*256+double(frame_header(7))*256*256+double(frame_header(8))*256*256*256;      
      end   
   end
   
   %==================================================================
   % (*1*)																				=
   % 																						=   
   % Reading Image Data (depening on number of bytes per pixel)      =
   % and rearrange it to image-matrix							            =
   %==================================================================
   switch bytes
      case 1
         % read 8bit per Pixel (greyscale) Data:
         xx = uint8(fread(fid, frame_length/bytes, 'uint8'));   
		   % reshape data as 2-dimentional image array:
  	      im = reshape(xx(1,:),columns,lines);
      case 2
         % read 16bit per Pixel Data:
         xx = uint16(fread(fid, frame_length/bytes, 'uint16'));
		   % reshape data as 2-dimentional image array:
         im = reshape(xx(1,:),columns,lines);
      case 3   
         % read 24bit per Pixel (truecolor) Data:
         xx = uint8(fread(fid, frame_length, 'uint8'));
         xx = reshape(xx,3,frame_length/3)';
         contador=contador+1;
         % reshape data as 3-dimentional truecolor image array
         % ([rows,lines,3], three color planes RGB):
         im(:,:,3) = rot90(reshape(xx(:,1),columns,lines));
         im(:,:,2) = rot90(reshape(xx(:,2),columns,lines));
         im(:,:,1) = rot90(reshape(xx(:,3),columns,lines));
         im2(:,:,contador)=im(:,:,1);
         
      otherwise  
         % read 32bit per Pixel Data:
         xx = uint32(fread(fid, frame_length/bytes, 'uint32'));
			% reshape data as 2-dimentional image array:
         im = double(reshape(xx,columns,lines));
      end           
      

  %=================================================================
  % (*2*)																			 =
  % 																					 =   
  % processing data of each frame starts here                      =
  % if you don't want to display any of the frames simply          =
  % delete the folowing lines...  (cut to cut)                     =
  %=================================================================
  
  %---cut---
  % display image data if needed:
  if option2>0;
     if ((i>=option2)&(i<=option3));
        figure('name',sprintf('Frame #%d',i));
        switch bytes
           case 1
              imshow(im');colormap(gray);  
           case 2
              imshow(im');colormap(gray); 
           case 3
              image(im);
           otherwise
              imshow(im);
        end 
     end   
  end
  
   
  %---cut---
  
  
    
  
  % My code comes here..
  
  
  

  %-----------------------------------------------------------------
  % Use the following varibles: 
  %
  % no_of_frames:   number of frames to be read
  % time_per_frame: time to display each frame [ms] (reverse of Frames 
  %					  per 0.001 second)
  % frames:			  number of this frame
  % columns:		  number of pixels per line
  % lines:			  number of lines per image
  % bytes:			  number of bytes per pixel
  % im:				  image data: 
  %					    8bit/pixel:  uint8-Matrix[columns,lines]
  %					    16bit/pixel: uint16-Matrix[columns,lines]
  %					    24bit/pixel: uint8-Matrix[columns,lines,3] 
  %					 	  			     (3 Color Planes R,G,B)
  %					    32bit/pixel: uint32-Matrix[columns,lines]
  % xx:				  raw image data:
  %					    8bit/pixel:  uint8-Matrix[columns*lines] 
  %										  (1-dimentional)
  %					    16bit/pixel: uint16-Matrix[columns*lines]
  %									 	  (1-dimentional)
  %					    24bit/pixel: uint8-Matrix[3,columns*lines] 
  %										  (1-dimentional, 3 Color Planes R,G,B)
  %					    32bit/pixel: uint32-Matrix[columns*lines]					  
  %										  (1-dimentional)
  %
  % Note: if you prefer another byte-arangement in order to speed up
  %		 your image processing refere to section (*1*) and modify 
  %	    the reshape commands in order to speed up the rearanging 
  %		 process
  %
  %-----------------------------------------------------------------
  
  
  %---------
  % store image in MatLab Movie-Format
  
  mov(i)=im2frame(im);
  
end  % end reading single frames -----------------------------------





% output read statistics:
disp('---------------------------------------------------------');
disp(sprintf('Read %d Blocks, %d valid Frames',i,frames));
disp('---------------------------------------------------------');
% plot results of maximum positions

output=mov;
movie(mov);

disp (['script done !']);
disp(' ');


