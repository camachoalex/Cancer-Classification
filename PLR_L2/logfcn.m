function [ Y ] = logfcn( X,B,alpha )
%     Y =  exp(alpha + X*B)./(1+exp(alpha + X*B) );
    Y = 1./(1+exp(-(alpha + X*B)));
    Y=Y';
end

