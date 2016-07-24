function [ X,Y ] = readData(fileName)
    % The purpose of this function is to read in the data and output the
    % response and explanatory variables, respectively.
    % X is a nxm matrix where each row denotes an observations.
    % Y is the response variable (0/1).
    
    DNA_DATA = xlsread(fileName);
    Y = DNA_DATA(1,:)';
    Y(Y==2) = 0; % changes the variables from 1 and 2 to 0 and 1. (Our preference)
    X = DNA_DATA(2:end,:)';
end

