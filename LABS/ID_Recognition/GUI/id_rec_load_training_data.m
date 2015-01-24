% load training data
inputs = [];
targets = [];

base_path=fullfile('GUI','id_rec','training_data');
dirs=dir(base_path);
for i=1:length(dirs)
    if regexp(dirs(i).name,'\w')
        files=dir(fullfile(base_path,dirs(i).name));
        for j=1:length(files)
            if regexp(files(j).name,'\w+')
                f=imread(fullfile(base_path,dirs(i).name,files(j).name));
                inputs=[inputs f(:)];
                target=false(11,1);
                switch dirs(i).name
                    case 'X'
                        target(1)=1;
                    otherwise
                        target(end-uint8(str2double(dirs(i).name)))=1;
                end
                targets=[targets target];
            end
        end
    end
end

nprtool
% save GUI\id_rec\model net

% for i=1:size(inputs,2)-1
%     for j=i+1:size(inputs,2)
%         if i~=j && sum(imabsdiff(inputs(:,i),inputs(:,j)))==0
%             i,j
%         end
%     end
% end