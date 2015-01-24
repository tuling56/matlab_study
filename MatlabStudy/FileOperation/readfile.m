clc
char set utf-8
fid=fopen('test.txt','r');
data=fread(fid)  %返回的是文本所有字符的ascii值
data_txt=char(data') %ascii转换为字符
data_num=str2num(data_txt)  %主要将数字字符转换为数值
fclose(fid);
