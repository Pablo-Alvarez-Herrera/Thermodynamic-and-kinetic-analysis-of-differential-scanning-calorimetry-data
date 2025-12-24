function [V_r] = reduction(V,r)

n=round(r*length(V));
index=round(linspace(1,length(V),n));
V_r=zeros(n,1);


for i=1:n
   V_r(i)=V(index(i));
end

end

