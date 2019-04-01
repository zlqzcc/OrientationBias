function [domain, probDnst] = estimatorPDF(stmSpc, F, intNoise, estimates, stimulus)

% external -> internal space (both with 0 and 2pi)
thetaTilde = interp1(stmSpc, F, stimulus);

% p(m_tilde | theta_tilde)
snsSpc = 0 : 0.01 : 2 * pi;
msmtDist = vonmpdf(snsSpc, thetaTilde, intNoise);

% m_tilde -> estimates
% change of variable
probDnst = abs(gradient(snsSpc, estimates)) .* msmtDist;
if(sum(isnan(estimates)) > 0 || sum(isnan(probDnst)) > 0)
    error('NaN Occurred.');
end

domain = stmSpc;
probDnst = interp1(estimates, probDnst, domain, 'linear', 'extrap');

end