% simple script to compute the LG AUC from testing images
% author: Angel Pineda
% date: 3/10/2023

% We set the scale for the Laguerre Gauss Channels

LGscale = 55; % chosen among the values that optimize AUC by also optimizing
% the fidelity of the estimate of the lesion using the LG channels.  Could 
% simply be chosen by maximizing AUC and there are many values that do that
% for the sample images.

AUC = LGAUC10('sample2AFCImages',LGscale)
% 1.0
