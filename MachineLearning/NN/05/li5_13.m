clear all;
%竞争层的输出
J=rands(20)';
%正向权值W和反向权值T
W=rands(20,5);
T=rands(20,5);
%警戒参数
threshold=0.8;
%两组模式A1和A2
A1=[1 1 0 0 0];
A2=[1 0 0 0 1];
%初始化
for i=1:20
    for j=1:5
        W(i,j)=1/6;
        T(i,j)=1;
    end
end
%判定是否接受识别结果
normalA1=norm(A1,1);
normalTA1=T(1,:)*A1';
count=1;
if normalTA1/normalA1>threshold
    J(count)=1;
end
%权值调整
W(1,:)=[0.4 0.4 0 0 0];
T(1,:)=[1 1 0 0 0];
%寻找可以记忆A2的神经元
for k=1:20
    s(k)=W(k,:)*A2';
    if s(k)==max(s);
        count=k;
    end
end
%如果和A1的神经元重复，继续寻找
if J(count)==1
    newcount=count+1;
end
for i=1:(count-1)
    p(i)=s(i);
end
for i=count:19
    p(i)=s(i+1);
end
for k=newcount:20
    if s(k)==max(p)
        count=k;
    end
end
%确定找到的神经元序号count，并令其对应的输出为1
J(count)=1;
%权值调整
W(count,:)=[0.4 0 0 0 0.4];
T(count,:)=[1 0 0 0 1];
J
