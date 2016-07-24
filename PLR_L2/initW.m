function W = initW(P,X)
    x = size(X);
    W=eye(x);
    n=length(P);
    for k=1:x(1)
        W(k,k) = P(k)*(1-P(k));
    end
end
        