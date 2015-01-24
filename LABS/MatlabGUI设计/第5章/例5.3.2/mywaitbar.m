function h = mywaitbar(x, whichbar, varargin)
if ischar(whichbar) || iscellstr(whichbar)   %调用格式为h = mywaitbar(p, 'title' , h_figure, x, y)
    if nargin == 5
        h_f = waitbar(x, whichbar, 'visible', 'off');  %创建一个临时进度条
        h1 = findall(h_f, 'type', 'axes');  %查找进度条内的坐标轴
        h_axs = copyobj(h1, varargin{1});   %将进度条内的坐标轴及其子对象拷贝到指定窗口内
        delete(h_f);
        pos = get(h_axs, 'position');
        set(h_axs, 'position', [varargin{2}, varargin{3}, pos(3 : 4)])
    end
elseif isnumeric(whichbar)                  %调用格式为mywaitbar(p, h)或mywaitbar(p, h, 'title')
    h_axs = whichbar;
    p = findobj(h_axs,'Type','patch');
    set(p, 'XData', [0 100*x 100*x 0])
    if nargin == 3                          %调用格式为mywaitbar(p, h, 'title')
        hTitle = get(h_axs, 'title');
        set(hTitle, 'string', varargin{1});
    end
end
if nargout == 1                             %返回内嵌进度条的句柄
    h = h_axs;
end
