function [MinD,BestPath]=MainAneal(CityPosition,pn)
global path p2 D;           %定义全局变量
[m,n]=size(CityPosition);
%生成初始解空间，这样可以比逐步分配空间运行快一些
TracePath=zeros(1e3,m);
Distance=inf*zeros(1,1e3);
D= sqrt((CityPosition( :,  ones(1,m)) - CityPosition( :,  ones(1,m))').^2 +...
    (CityPosition( : ,2*ones(1,m)) - CityPosition( :,2*ones(1,m))').^2 );
%将城市的坐标矩阵转换为邻接矩阵（城市间距离矩阵）
for i=1:pn
    path(i,:)=randperm(m);%构造一个初始可行解
end
t=zeros(1,pn);
p2=zeros(1,m);
iter_max=100;%input('请输入固定温度下最大迭代次数iter_max=' );
m_max=5;%input('请输入固定温度下目标函数值允许的最大连续未改次数m_nax=' ) ;
%如果考虑到降温初期新解被吸收概率较大，容易陷入局部最优
%而随着降温的进行新解被吸收的概率逐渐减少，又难以跳出局限
%人为的使初期 iter_max,m_max 较小，然后使之随温度降低而逐步增大,可能
%会收到到比较好的效果
T=1e5;
N=1;
tau=1e-5;%input('请输入最低温度tau=' );
while  T>=tau%&m_num<m_max          
       iter_num=1;%某固定温度下迭代计数器
       m_num=1;%某固定温度下目标函数值连续未改进次数计算器
       while m_num<m_max&iter_num<iter_max
        %MRRTT(Metropolis, Rosenbluth, Rosenbluth, Teller, Teller)过程:
             %用任意启发式算法在path的领域N(path)中找出新的更优解
             for i=1:pn
                 Len1(i)=sum([D(path(i,1:m-1)+m*(path(i,2:m)-1)) ...
D(path(i,m)+m*(path(i,1)-1))]);
                  %计算一次行遍所有城市的总路程 
                 [path2(i,: )]=ChangePath2(path(i,: ),m);%更新路线
                 Len2(i)=sum([D(path2(i,1:m-1)+m*(path2(i,2:m)-1)) ...
D(path2(i,m)+m*(path2(i,1)-1))]);
             end
             R=rand(1,pn);             
             if find((Len2-Len1<t|exp((Len1-Len2)/(T))>R)~=0)
                 path(find((Len2-Len1<t|exp((Len1-Len2)/(T))>R)~=0), : )=...
path2(find((Len2-Len1<t|exp((Len1-Len2)/(T))>R)~=0), : );
                 Len1(find((Len2-Len1<t|exp((Len1-Len2)/(T))>R)~=0))=...
Len2(find((Len2-Len1<t|exp((Len1-Len2)/(T))>R)~=0));
                 [TempMinD,TempIndex]=min(Len1);
                 TracePath(N,: )=path(TempIndex,: );
                 Distance(N,: )=TempMinD;
                 N=N+1;                 
                 m_num=0;
             else
                 m_num=m_num+1;
             end
             iter_num=iter_num+1;
         end
         T=T*0.9
end 
[MinD,Index]=min(Distance);
BestPath=TracePath(Index,: );
disp(MinD)
