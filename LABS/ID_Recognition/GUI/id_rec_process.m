function [ id_codes,id_bw,code_stats,thresh ] = id_rec_process( img_gray,model,thresh )
global iteration
narginchk(2,3)
if  nargin==2
    thresh=.68*graythresh(img_gray);
end
fprintf('Iteration %d, threshold value: %f\n',iteration,thresh)
bw=~im2bw(img_gray,thresh);
bw=imclearborder(bwareaopen(bw,10));
bwc=imdilate(bw,strel('disk',6));
code_stats=regionprops(bwc,'Area');
step_ratio=1.1;
if isempty(code_stats) && thresh*step_ratio<1
    iteration=iteration+1;
    [id_codes,id_bw,code_stats,thresh]=id_rec_process(img_gray,model,thresh*step_ratio);
    return;
end
[~,midx]=max([code_stats.Area]);
mask=bwlabel(bwc)==midx;
id_bw=imreconstruct(mask,bw);
code_stats=regionprops(id_bw,'Image','Extent');

if length(code_stats)~=18 && thresh*step_ratio<1
    iteration=iteration+1;
    [id_codes,id_bw,code_stats,thresh]=id_rec_process(img_gray,model,thresh*step_ratio);
    return;
end

inputs=[];
j=1;
for i=1:18
    img=imresize(code_stats(i).Image,[47 31]);
    inputs=[inputs img(:)];
    j=j+1;
end

% predict
output=model(inputs);
[~,midx]=max(output);
count=size(output,2);
id_codes=blanks(count);
for i=1:count
    switch midx(i)
        case 1
            id_codes(i)='X';
        otherwise
            id_codes(i)=num2str(11-midx(i));
    end
end
end