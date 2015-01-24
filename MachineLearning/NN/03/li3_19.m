 clear all;
%初始化
P=[-6.0 -6.1 -4.1 -4.0 5.0 -5.1 6.0 6.1];
T=[0 0 0.97 0.99 0.01 0.03 1.0 1.0];
[R,Q]=size(P);
[S,Q]=size(T);
disp('The bias B is fixed at 300 and will not learn')
Z1=menu('Initalize Weight with:',...            %作菜单
    'W0=[-0.9];B0=3;',...                       %按给定的初始值
    'Pick Values with Mouse/Arrow Keys',...     %用鼠标在图上任点初始值
    'Random Inital Condition[Defaut];');        %随机初始值（缺省情况）
disp('')
B0=3;
if Z1==1
    W0=[-0.9];
elseif Z1==3
    W0=rand(S,R);
end
%作权值一误差关系图并标注初始值
% 作网络误差曲线图
error1=[];
net=newcf(minmax(P),[1],{'logsig'});             %创建非线性单层网络
net.b{1}=B0;
j=[-1:0.1:1];
for i=1:21
    net.iw{1,1}=j(i);
    y=sim(net,P);
    err=sumsqr(y-T);
    error1=[error1 err];
end
plot(j,error1);                                 %网络误差曲线图
hold on;
Z2=menu('Use momentium constant of:',...        %作菜单
    '0.0',...
    '0.95 [Default]');
if Z1==2
    [W0,dummy]=ginput(1);
end
disp('')
%训练网络
if Z2==1
    momentum=0;
else
    momentum=0.95;
end
ls=[];error=[];w=[];
max_epoch=500;
err_goal=0.01;
lp.lr=0.05; lp.mc=momentum;                 %赋初值
err_ratio=1.04;
W=W0; B=B0;
A=logsig(W0*P+B0*ones(1,8));
E=T-A;
SSE=sumsqr(E);
for epoch=1:max_epoch
    if SSE<err_goal
        epoch=epoch-1;
        break;
    end
    D=A.*(1-A).*E;
    gW=D*P';
    dw=learngdm([],[],[],[],[],[],[],gW,[],[],lp,ls);         %权值的增量
    ls.dw=dw;                                   %赋学习状态中的权值增量
    TW=W+dw;                                     %变化后的权值
    TA=logsig(TW*P+B*ones(1,8));
    TE=T-TA;
    TSSE=sumsqr(TE);
    if TSSE>SSE*err_ratio                       %判断赋动量因子
        mc=0;
    elseif TSSE<SSE
        mc=momentum;
    end
    W=TW; A=TA;
    E=TE; SSE=TSSE;
    error=[error TSSE];                   %记录误差
    w=[w W];
end
hold off;
figure;plot(error);                      %训练误差图
