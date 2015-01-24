function nedge=connect(nedge,y,x,low)       %种子定位后的连通分析
    neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %八连通搜寻
    [m n]=size(nedge);
    for k=1:8
        yy=y+neighbour(k,1);
        xx=x+neighbour(k,2);
        if yy>=1 &&yy<=m &&xx>=1 && xx<=n  
            if nedge(yy,xx)>=low && nedge(yy,xx)~=255   %判断下阈值
                nedge(yy,xx)=255;
                nedge=connect(nedge,yy,xx,low);
            end
        end        
    end 

end