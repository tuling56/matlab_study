clear all;
%初始化正向权值w和反向权值v
w=rands(18,2)/2+0.5;
v=rands(5,18)/2+0.5;
%输入向量P和目标向量T
P=[0 0;0.5 0.5;0 0.5;1 1;0.5 1;1 0.5];
T=[1 0 0 0 0;1 0 0 0 0;0 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 0 0 0 1];
T_out=T;
%设定学习步数为1000次
epoch=1000;
%归一化输入向量P
for i=1:6
    if P(i,:)==[0 0];
        P(i,:)=P(i,:);
    else
        P(i,:)=P(i,:)/norm(P(i,:));
    end
end
%开始训练
while epoch>0
    for j=1:6
        %归一化正向权值w
        for i=1:8
            w(i,:)=w(i,:)/norm(w(i,:));
            s(i)=P(j,:)*w(i,:)';
        end
        %求输出为最大的神经元，即获胜神经元
        temp=max(s);
        for i=1:8
            if temp==s(i)
                count=i;
            end
            %将所有竞争层神经元的输出置为0
            for i=1:8
                s(i)=0;
            end
            %将获胜神经元的输出置为1
            s(count)=1;
            %权值调整
            w(count,:)=w(count,:)+0.1*[P(j,:)-w(count,:)];
            w(count,:)=w(count,:)/norm(w(count,:));
            v(:,count)=v(:,count)+0.1*(T(j,:)'-T_out(j,:)');
            %计算网络输出
            T_out(j,:)=v(:,count)';
        end
        %训练次数递减
        epoch=epoch-1;
    end
    %训练结束
end
T_out
    %网络回想，其输入模式为Pc
    Pc=[0.5 1;1 1];
    %初始化Pc
    for i=1:2
        if Pc(i,:)==[0 0]
            Pc(i,:)=Pc(i,:);
        else
            Pc(i,:)=Pc(i,:)/norm(Pc(i,:));
        end
    end
    %网络输出
    Outc=[0 0 0 0 0;0 0 0 0 0];
    for j=1:2
        for i=1:18
            sc(i)=Pc(j,:)*w(j,:)';
        end
        tempc=max(sc);
        for i=1:18
            if tempc==sc(i)
                countp=i;
            end
            sc(i)=0;
        end
        sc(countp)=1;
        Outc(j,:)=v(:,countp)';
    end
    %回想结束
    Outc
