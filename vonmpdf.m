function density = vonmpdf(support, mu, kappa)
density = exp(kappa * cos(support - mu)) / (2 * pi * besseli(0, kappa));
end

