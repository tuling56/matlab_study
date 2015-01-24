[fname pname index] = uigetfile({'*.jpg'; '*.bmp'}, '选择图片');  %文件选择对话框
if index                   %若选择了图片
    str = [pname fname];   %获取图片路径和图片名
    M = imread(str);       %读取图片
    imshow(M);             %显示图片
end
