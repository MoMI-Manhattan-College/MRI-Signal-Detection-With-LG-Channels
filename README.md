# MRI-Signal-Detection-With-LG-Channels

This repository contains code used in a paper published in Physics in Medicine and Biology:

Pineda AR, Miedema H, Lingala SG, Nayak KS, “Optimizing constrained reconstruction in magnetic resonance imaging for signal detection”, Physics in Medicine and Biology, 66, 2021, 145014.

## Observer Model

The code in the Observer-Models Folder runs uses a Laguerre-Gauss Channelized Hotelling Observer with 10 channels for estimating the area under the ROC curve (AUC) for a sample two-alternative forced choice (2-AFC) dataset.  This is an approximation to the ideal linear observer performance.  There is one MATALB function and one script in the folder along with a sample data set. 

runLG10_for2AFC.m:
This script sets the parameters of the Laguerre-Gauss (LG) model and calls the LGAUC10.m function to compute the area under the ROC (AUC).  T

LGAUC10.m:
This function has the image array and the parameters of the LG model as input and outputs the AUC.

Sample2AFCIImages.mat:
This data file contains a sample set of 40 images generated from the fastMRIdata raw data of FLAIR images:
https://github.com/facebookresearch/fastMRI
The data file has the parameters for the reconstruction along with the signal image, forty 128x128 images with the signal in the center and forty 128x128 images with just the background. 

Directions:

To run the model observer code to estimate the AUC from the image file, simply run "runLG10_forAUC.m" in a folder with the supporting files.

Once you run this code it will prodice an estimate of the AUC for the LG model observer for the 2-AFC images.
