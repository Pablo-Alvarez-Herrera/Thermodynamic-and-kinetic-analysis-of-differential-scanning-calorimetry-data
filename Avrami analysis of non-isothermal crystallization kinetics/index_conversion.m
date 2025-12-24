function [j] = index_conversion(X,x)

j=1;
i=1;
while X(i) < x
    i= i+1;
    j =i;
end
end

