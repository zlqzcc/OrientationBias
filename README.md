# Efficient Coding Orientation Fitting
Fit bayesian efficient coding model (Wei & Stocker 2015) with the method in (Stocker & Simoncelli 2006) to orientation bias data (collected with method of adjustment).


## Dependencies
You will need Bayesian Adaptive Direct Search [`bads`](https://github.com/lacerbi/bads) OR [`fminsearchbnd`](https://www.mathworks.com/matlabcentral/fileexchange/8277-fminsearchbnd-fminsearchcon) to run the fitting procedure efficiently.  

## Scripts
`main.m` Run fit on combined subject and plot the results.  
`mainBootstrap.m` Run bootstrap fit on combined subject.  
`mainSubjects.m` Run fit on individual subjects separately and plot the results.  
`plotSubjectFit.m` (Load in best fit parameter) Generate the result figure for each subject (with scatter plot of raw data).  

## Functions
`dataLlhd.m` Data likelihood (for method of adjustment)  
- `thetaEstimator.m` Calculate the optimal estimate from a measurement give the noise and prior  
- `estimatorPDF.m` Generate the predictive distribution p(theta_hat | theta)  
- `motorConv.m` Convolve the predictive distribution with (Gaussian) motor noise.  

`fitSubjects.m` Read in data file from ./Data_mat_files and run the fit for each individual subjects.  
`modelVis.m` Visualization of model prediction and error bars given the parameter.  
`optWrapper.m` Wrapper function of likelihood that actually runs the fitting procedure.  
