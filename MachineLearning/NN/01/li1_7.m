 clear all;
for i=1:10
    a{i}=89+i;
    b{i}=79+i;
    c{i}=69+i;
    d{i}=59+i;
end
c=[d,c];
Name={'zhang','Li','huang','chen','zhu'};  %元胞数组
Score={82,91,89,40,100};
Rank=cell(1,5);
%创建一个含有5个元素的结构体数组S，它有三个域：Name、Score、Rank：
 S=struct('Name',Name,'Score',Score,'Rank',Rank);
%根据学生的分数，求出相应的等级：
%将学生的姓名、得分、登记等信息打印出来：
 disp(['学生姓名   ','得分   ','等级']);
for i=1:5
    disp([S(i).Name,blanks(6),num2str(S(i).Score),blanks(6),S(i).Rank]);
end
