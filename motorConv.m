function [probDnst] = motorConv(mtrNoise, domain, probDnst)
% Motor noise, gaussian kernel
deltaKernel = 0.001;
support = -1 : deltaKernel : 1;
kernel  = normpdf(support, 0, mtrNoise) * deltaKernel;

% Conv with density function
probDnst = conv(repmat(probDnst, [1, 3]), kernel, 'same');
probDnst = probDnst((length(domain) + 1) : 1 : (length(domain) * 2));
end

