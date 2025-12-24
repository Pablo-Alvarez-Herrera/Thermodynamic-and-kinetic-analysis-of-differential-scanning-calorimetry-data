function [t_delta,X_delta,X_Avrami] = Avrami_model(t,X,n,K,delta)

deltas=0:delta:1;

L=length(deltas);
index=zeros(L,1);
X_delta=zeros(L,1);
t_delta=zeros(L,1);

for i=1:L
  index(i,1)=index_conversion(X,deltas(i));
  X_delta(i)=X(index(i,1));
  t_delta(i)=t(index(i,1));
end

X_Avrami=zeros(length(t),1);

for j=1:length(t)
    X_Avrami(j,1)=1-exp(-K*(t(j)^n));
end
end

