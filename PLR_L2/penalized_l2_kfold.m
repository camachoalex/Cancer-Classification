function [Z, est_coef]=penalized_l2_kfold(X,Y, min_lambda ,max_lambda,steps)
    % This function will output a cell matrix with the estimated RR
    % coefficients as a column (est_coef) with the first value corresponding to
    % the chosen regularization term, lambda. (i.e. [lambda; coef].

    addpath(genpath(pwd))
    % safety check
    if(max_lambda < min_lambda)
        disp('Error in lambda range.');
        return;
    end
    if min_lambda == max_lambda || steps==0
        steps=1;
    end
    
    % load data 
    [n, m ] =size(X);
 % standardize data set
% %      X = (X-mean(X(:))./std(X(:)));
%     sprintf('Lambda test range: (%f, %f).',min_lambda,max_lambda)

    for lambda = linspace(min_lambda,max_lambda,steps)
        B = zeros(1, m)';
        U = ones(1,n);
        alpha_tilde = log(mean(Y)./(1-mean(Y)));    
        P = logfcn(X,B,alpha_tilde)';
        W=eye(n);
        for k =1:length(P)
            W(k,k) = P(k)*(1-P(k));
        end

        % Equation 12 from shan and ten.
        gamma_tilde = [alpha_tilde ;B]';
        Z = [U' X];
        R = eye(m+1,m+1); R(1,1) =0;

        AA = (Z'*W*Z+lambda*R);
        BB = Z'*((Y-P)+W*Z*gamma_tilde');
        
        est_coef =  AA\BB  ;
    end
end


