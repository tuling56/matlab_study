 % GMMB_EM_INIT_FCM1
 %
 % initS = gmmb_em_init_fcm1(data, C, verbose)
 %
 % Create an initialization structure for EM,
 % called from gmmb_em, see gmmb_em.
 %
 % Fuzzy C-means clustering means, uniform weight and covariance
 % Requires the Fuzzy Logic Toolbox.
 %
 % Author(s):
 %    Pekka Paalanen <pekka.paalanen@lut.fi>
 %
 % Copyright:
 %
 %   Bayesian Classifier with Gaussian Mixture Model Pdf
 %   functionality is Copyright (C) 2004 by Pekka Paalanen and
 %   Joni-Kristian Kamarainen.
 %
 %   $Name:  $ $Revision: 1.1 $  $Date: 2004/08/16 15:06:44 $
 
 function initS = gmmb_em_init_fcm1(data, C, verbose);
 
 D = size(data,2);    % dimensions
 
 % mu = zeros(D,C);
 
 % mus initialization (thanks V. Kyrki)
 if C>1
     mu = fcm(data, C, [2.0 100 1e-3 verbose]).';
     % fcm initialization has random nature, results will vary
 else
     mu = mean(data, 1).';
 end
 
 % covariances initialization
 nsigma = covfixer2(diag(diag(cov(data))));
 sigma = zeros(D,D,C);
 for c = 1:C
     sigma(:,:,c) = nsigma;
 end
 
 % weights initialization
 weight = ones(C,1) * (1/C);
 
 initS = struct(...
     'mu', mu, ...
     'sigma', sigma, ...
     'weight', weight ...
     );