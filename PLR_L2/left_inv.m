function [A] = left_inv(W)
    A = W'*W;
    for k=1:length(A)
        if(A(k,k))~=0
            A(k,k) = 1/A(k,k);
        end
    end
    A = A*W'