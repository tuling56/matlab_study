figure(2)                               %创建窗口
hm = findall(2, 'type', 'uimenu');      %查找标准菜单
delete(hm)                              %删除标准菜单
h = findall(2, 'type', 'uipushtool', '-or', 'type', 'uitoggletool'); %查找工具按钮
set(h, 'visible', 'off')                %隐藏工具按钮
h1 = findall(2, 'Tooltip', 'Zoom In', '-or', 'Tooltip', 'Zoom Out',...
    '-or', 'Tooltip', 'Pan', '-or', 'Tooltip', 'Data Cursor');
set(h1, 'visible', 'on', 'Separator', 'off')  %显示指定的4个工具按钮
