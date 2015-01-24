function [gamma,llm]=em2r(r,k)
load ('data.mat')
x=dataset2;
L=size(x);
l=L(1);
zc=zeros(r,40);llm=-inf;
for zzz=1:r
sigma=zeros(2,2,k);
mu=zeros(k,2);
sigma(:,:,1)=cov(x);
n=zeros(1,3);
pik=ones(k,1)/k;
while (~(n(1)~=n(2)&&n(2)~=n(3)&&n(3)~=n(1)))
    n=ceil(rand(1,3)*1500);
end
for ii=1:k
    mu(ii,:)=x(n(ii),:);
    sigma(:,:,ii)=sigma(:,:,1);
end
for zz=1:40
p=zeros(l,k);
for ii=1:k
    p(:,ii)=mvnpdf(x,mu(ii,:),sigma(:,:,ii));
end
gamma=zeros(l,k);
for ii=1:l
    su=0;
    for jj=1:k
        su=pik(jj)*p(ii,jj)+su;
    end
    for jj=1:k
        gamma(ii,jj)=pik(jj)*p(ii,jj)/su;
    end
end
nk=zeros(k,1);
for ii=1:k
    nk(ii)=sum(gamma(:,ii));
end
pik=nk/l;
for ii=1:k
    mu(ii,1)=sum(gamma(:,ii).*x(:,1))/nk(ii);
    mu(ii,2)=sum(gamma(:,ii).*x(:,2))/nk(ii);
end
ssig=zeros(2,2,l);
for ii=1:k
    for jj=1:l
        ssig(:,:,jj)=gamma(jj,ii).*(x(jj,:)-mu(ii,:))'*(x(jj,:)-mu(ii,:));
    end
    sigma(1,1,ii)=sum(ssig(1,1,:))/nk(ii);
    sigma(1,2,ii)=sum(ssig(1,2,:))/nk(ii);
    sigma(2,1,ii)=sum(ssig(2,1,:))/nk(ii);
    sigma(2,2,ii)=sum(ssig(2,2,:))/nk(ii);
end
ll=0;
for ii=1:l
    bb=0;
    for jj=1:k
        bb=bb+pik(jj)*mvnpdf(x(ii,:),mu(jj,:),sigma(:,:,jj));
    end
    ll=ll+log(bb)/log(exp(1));
end
zc(zzz,zz)=ll;
end
if llm<ll
    llm=ll;
    mii=zzz;
    gam=gamma;
end
end
figure (4)
subplot(1,2,1);
for ii=1:l
plot(x(ii,1),x(ii,2),'.','color',gam(ii,:));
hold on
end
hold off;
subplot(1,2,2)
plot(1:40,zc(mii,:));
xlabel('iteration times')
ylabel('maximum log-likelihood')
end