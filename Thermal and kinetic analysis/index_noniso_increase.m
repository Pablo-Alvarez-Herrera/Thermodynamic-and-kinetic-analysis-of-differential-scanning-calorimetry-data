function [j] = index_noniso_increase(T,t)

j=1;
i=1;
while T(i) < t
    i= i+1;
    j =i;
end
end

