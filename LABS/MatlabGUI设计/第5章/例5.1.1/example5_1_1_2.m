h = waitbar(0, '请等待...', 'Name', '进度条', 'CreateCancelBtn', ...
    'state = 1; delete(h); clear h');       %创建进度条
h1 = findall(h, 'style', 'pushbutton');     %查找【取消】按钮
set(h1, 'string', '取消', 'fontsize', 10)   %设置【取消】按钮的String为“取消”
try
    for i = 1 : 100                         %更新进度
        waitbar(i / 100, h, ['进度完成' num2str(i) '%']);
        pause(0.1)
end
delete(h);                                  %进度达到100%或中断后，关闭进度条
clear h
end
