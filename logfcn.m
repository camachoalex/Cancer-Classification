function [ Y ] = logfcn( B,X )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    Y =  exp(X*B)./(1+exp(X*B) );
    Y=Y';
end

