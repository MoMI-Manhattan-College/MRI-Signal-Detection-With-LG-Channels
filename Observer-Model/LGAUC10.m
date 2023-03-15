function [AUC] = LGAUC10(dataFileName,LGscale)

% Author: Angel Pineda
% Date: 7/8/2018

% This function takes the dataFileName and the LGscale as inputs,
% where dataFileName is the name of the file with the images
% used and LGscale is the scale parameter for the Laguerre Gauss
% channels.  The LGscale parameter is optimized separately by doing
% a grid search to find the value that maximizes the AUC for this data set.

% The output is the area under the ROC curve for the detection of the
% signal using 10 Laguerre-Gauss Channels for a signal in the center of
% the images.

% We load data

% We combine the character vectors dataFileName (name of the file)
% and .mat then returns the new character vector to data_file_name
data_file_name = strcat(dataFileName,'.mat');

% load variables from the .mat file that contains the image arrays
% into the workspace
load(data_file_name);

% nImages is equal to the number of images in the tumorImageArray
% dimX is equal to the number of pixels in the x direction of the images in
% the tumorImageArray
[nImages, dimX, ~] = size(signalImageArray);
nPixels = dimX;


%% Generate channel profiles

D = zeros(nPixels,nPixels); % Distancs in Pixels
% We create the Laguerre Gauss Channels, with au optimized
% for this signal.

au = nPixels/LGscale; %
LG0 = zeros(nPixels,nPixels);
LG1 = zeros(nPixels,nPixels);
LG2 = zeros(nPixels,nPixels);
LG3 = zeros(nPixels,nPixels);
LG4 = zeros(nPixels,nPixels);
LG5 = zeros(nPixels,nPixels);
LG6 = zeros(nPixels,nPixels);
LG7 = zeros(nPixels,nPixels);
LG8 = zeros(nPixels,nPixels);
LG9 = zeros(nPixels,nPixels);
L0 = sqrt(2)/LGscale;

% We generate the Laguerre-Gauss Channels

% The LG channels are centered at the signal location (pLoc,pLoc)
pLoc = nPixels/2+1;

for i=1:nPixels
    for j=1:nPixels
        D(i,j) = (i-pLoc)^2+(j-pLoc)^2;
        x = D(i,j)/(au^2);
        xp = 2*pi*x;
        LG0(i,j) = L0 * exp(-pi*x);
        LG1(i,j) = L0 * exp(-pi*x) * (-xp + 1);
        LG2(i,j) = L0 * exp(-pi*x) * (1/2)*  (xp^2  - 4*xp    +2);
        LG3(i,j) = L0 * exp(-pi*x) * (1/6)*  (-xp^3 + 9*xp^2  -18*xp     + 6);
        LG4(i,j) = L0 * exp(-pi*x) * (1/24)* (xp^4  - 16*xp^3 + 72*xp^2  - 96*xp    + 24);
        LG5(i,j) = L0 * exp(-pi*x) * (1/120)*(-xp^5 + 25*xp^4 - 200*xp^3 + 600*xp^2 - 600*xp + 120);
        LG6(i,j) = L0 * exp(-pi*x) * (1/720)*(xp^6  -36*xp^5   + 450*xp^4 - 2400*xp^3 + 5400*xp^2 - 4320*xp + 720);
        LG7(i,j) = L0 * exp(-pi*x) * (1/5040)*(-1*xp^7 +49*xp^6 -882*xp^5 + 7350*xp^4 - 29400*xp^3 + 52920*xp^2 - 35280*xp + 5040);
        LG8(i,j) = L0 * exp(-pi*x) * (1/40320)*(xp^8-64*xp^7+1568*xp^6-18816*xp^5 + 117600*xp^4 - 376320*xp^3 + 564480*xp^2 - 322560*xp + 40320);
        LG9(i,j) = L0 * exp(-pi*x) * (1/362880)*(-xp^9 + 81*xp^8 - 2592*xp^7 + 42336*xp^6 - 381024*xp^5 + 1905120*xp^4 - 5080320*xp^3 + 6531840*xp^2 - 3265920*xp + 362880);
    end
end

% initializing a data array to hold the 10 channel features for each
% image with the signal and without the signal
signalDataArray = zeros(nImages, 10);
backgroundDataArray = zeros(nImages, 10);

% for loop that computes the features for all of the images in the
% signalImageArray and the backgrounfImageArray
for i = 1:nImages

    % selecting ith image in signalImageArray and squeezing it to be 1 image
    % that is dimx
    signalPresentImage = squeeze(signalImageArray(i,:,:));

    % generating the channel features for ith image by taking the inner
    % product of the signal images and the channels

    features(1) = sum(sum(LG0.*signalPresentImage));
    features(2) = sum(sum(LG1.*signalPresentImage));
    features(3) = sum(sum(LG2.*signalPresentImage));
    features(4) = sum(sum(LG3.*signalPresentImage));
    features(5) = sum(sum(LG4.*signalPresentImage));
    features(6) = sum(sum(LG5.*signalPresentImage));
    features(7) = sum(sum(LG6.*signalPresentImage));
    features(8) = sum(sum(LG7.*signalPresentImage));
    features(9) = sum(sum(LG8.*signalPresentImage));
    features(10) = sum(sum(LG9.*signalPresentImage));


    % storing the channel features of each image in ith position in
    % signalDataArray
    signalDataArray(i,:)=features;

    % selecting ith image in backgroundImageArray and squeezing it to be 1 image
    % that is dimx
    backgroundImage = squeeze(backgroundImageArray(i,:,:));

    % Generating the channel features for ith image by taking the inner
    % product of the background images and the channels

    features(1) = sum(sum(LG0.*backgroundImage));
    features(2) = sum(sum(LG1.*backgroundImage));
    features(3) = sum(sum(LG2.*backgroundImage));
    features(4) = sum(sum(LG3.*backgroundImage));
    features(5) = sum(sum(LG4.*backgroundImage));
    features(6) = sum(sum(LG5.*backgroundImage));
    features(7) = sum(sum(LG6.*backgroundImage));
    features(8) = sum(sum(LG7.*backgroundImage));
    features(9) = sum(sum(LG8.*backgroundImage));
    features(10) = sum(sum(LG9.*backgroundImage));

    % storing the channel features of each image in ith position in
    % backgroundDataArray
    backgroundDataArray(i,:)=features;

end




% Generating the data arrays

tumorDataI = signalDataArray;

noTumorDataI = backgroundDataArray;


% Creating the data tables for classification

DataI = [tumorDataI ; noTumorDataI];
DataI = [DataI [ones(nImages,1); zeros(nImages,1)]];

DataTableI = array2table(DataI);

% We fit the linear discriminant

LDADataI = fitcdiscr(DataTableI,'DataI11');

% We comput the AUC and the ROC

[label,score,cost] = predict(LDADataI,DataTableI);
[FPR,TPR,T,AUC] = perfcurve([ones(nImages,1); zeros(nImages,1)],score(:,2),'1');

disp(AUC)


% Plotting the ROC to check
% plot(FPR,TPR)
% xlabel('False positive rate')
% ylabel('True positive rate')
% title('ROC for LDA')

