 clear all;
fid = fopen('magic.m','r');
count = 0;
while ~feof(fid)
    line = fgetl(fid);
    if isempty(line) || strncmp(line,'%',1) || ~ischar(line)
        continue
    end
    count = count + 1;
end
disp('magic.m�ļ�������Ϊ��')
fprintf('%d lines\n',count);
fclose(fid);