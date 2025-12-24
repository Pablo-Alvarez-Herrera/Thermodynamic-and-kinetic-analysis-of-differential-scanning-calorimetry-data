function [X] = conversion(T,Q)

X=zeros(length(T),1);

for i=2:length(T)
    
    X(i,1)=trapz(T(1:i),Q(1:i));
end 

X=X/X(length(T),1);
end

