gca;                                                  %设置当前坐标轴用于绘制曲线
h = waitbar(0, '开始绘图...', 'WindowStyle', 'modal'); %创建置于屏幕前端的进度条，动态显示绘图进度
t = [0 : 0.01 : pi];                                  %数据的横坐标
try
    for i = 1 : 10
        plot(t, sin(2 * pi * i * t));                     %绘制数据曲线
        waitbar(i / 10, h, ['已完成' num2str(10 * i) '%']);%更新进度条的进度和标题
        pause(1)                                          %延迟1秒
    end
    delete(h)                                             %关闭进度条
end

