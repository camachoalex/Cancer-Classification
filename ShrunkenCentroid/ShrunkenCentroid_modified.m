function [accuracy,class_of_test] = ShrunkenCentroid(xtrain,xtest, numFolds, lambda)

    [p n]=size(xtrain);
    class = xtrain(1,:) == 1; %specifiy which column is ,1 is cancer and 2 is not
    ytrain = xtrain(1,:);
    n_one = sum(class); n_two = n - n_one; % find out the number of n_k
    newX = xtrain(2:p,:); %delete first row
    
    x_i1 = sum(newX(:,class)')/n_one; %find the centroid of class 1, where each element of vector 'x_i1' denote the i th component, row vector
    x_i2= sum(newX(:,~class)')/n_two; %component of centroid of class 2, row vector too
    x_i = sum(newX')/n; %component of overall centroid
    
    % compute s_i_square
    temp = zeros(size(newX));
    temp(:,class) = x_i1'*ones(1,n_one);%create a matrix with column vector x_i1 that corresponding to the column of sample of class 1
    temp(:,~class) = x_i2'*ones(1, n_two); 
    S =  (1/(n-2))*(newX-temp).^2;
    s_i_square = sum(S'); % s_i square in the paper
    m_1 = sqrt(1/n_one - 1/n); m_2 = sqrt(1/n_two - 1/n); %easy to see what this is
    d_i1 = (x_i1 - x_i)'./(m_1*sqrt(s_i_square)');  
    d_i2 = (x_i2 - x_i)'./(m_2*sqrt(s_i_square)');

    %use cv to choose lambda
    s_i = sqrt(s_i_square);
 
    d_i1_new = sign(d_i1).*subplus((abs(d_i1)-lambda)); 
    d_i2_new = sign(d_i2).*subplus((abs(d_i2)-lambda)); 
    x_i1_new = x_i' + m_1*s_i'.*d_i1_new; %column vector
    x_i2_new = x_i' + m_2*s_i'.*d_i2_new;

    test = xtest(2:end,:); 
    test_y = xtest(1,:);
    % We need to compute its discriminant score for class k to classify it
    class_of_test=[];
    for j = 1:length(test_y)
        delta_1 = sum(((test(:,j)'-x_i1_new').^2)./s_i_square); 
        delta_2 = sum(((test(:,j)'-x_i2_new').^2)./s_i_square);
        %now we classify it
        if delta_1 < delta_2
            class_of_test(j) = 1;
        else
            class_of_test(j) = 0;
        end
    end
    %% Compute the accuracy and the cross validation.
    accuracy = sum(test_y == class_of_test)/length(test_y);
    
end