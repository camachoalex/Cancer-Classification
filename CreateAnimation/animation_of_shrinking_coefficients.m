min_lambda = -1;
max_lambda = 1;
steps = 200;
penalized_l2(min_lambda ,max_lambda,steps)
load CV_results.mat
for k=1:length(est_coef)
    B = est_coef{k};
    lambda = B(1);
    B = B(2:end);
    stem(B);
    axis([0 245 -1.25 1.25]);
    xlabel('coefficients');
    ylabel('weight');
    title(sprintf('lambda:%f',lambda));
    pause(0.01)
    shg
end
