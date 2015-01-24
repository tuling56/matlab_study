function [ p_cluster ] = em(p_sample, k, feature_num, sample_num)
%UNTITLED1 Summary of this function goes here
%  Detailed explanation goes here

%初始化k个中心
p_cluster = p_sample(:,1:k);
p_cluster = p_cluster';%(p_cluster-500*51)
para = 0.5;
para = 1/sqrt(2 * para);
%进行迭代
for i=1:2000
    %E步
    p_dist = para * dist(p_cluster, p_sample);
    p_dist = radbas(p_dist);
    p_dist_sum = sum(p_dist);
    for i1=1:sample_num
        e_z(:,i1) = p_dist(:,i1)/p_dist_sum(i1);
    end
    
    %M步
    for i2=1:k
        %u'的分子部分
        p_temp_vec = zeros(2,1);
        for i3=1:sample_num
            p_temp_vec = p_temp_vec + e_z(i2,i3) * p_sample(:,i3);
        end 
        p_cluster(:,i2)=p_temp_vec./sum(e_z(i2,:));
    end    
end
p_cluster = p_cluster';
