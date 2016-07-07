README
Program name: gbrt.m

Contact Info:


Release Date:

System Requirements:????? MATLAB?


INTRODUCTION
This function uses gradient boosted regression trees to relate the training Data to the training labels.  It can be used for regression, classification, multi class regression, multi-class classification, and any model that uses gradient boosted regression trees.  

USE:
1.  Load Data -  See Demo1_data.m
Specify Options
2.  Run the gbrt program
Optional: Cross Validate
3. Test

CODE STRUCTURE - gbrt.m

>>options.ntrees = 100 %%Specify Options
>>[e,l] = gbrt(xr,@(p)LossFunction(yr,p),options); %%Run the Program
>>

INPUT
xr = Training Data
yr = Training Labels
p = variable for predictions

OPTIONS
There are 4 different options that you can specify: 
options.ntrees = Number of trees in ensemble, must be an integer.
options.depth = The depth of the tree, must be an integer.
options.learningrate = learning rate, must be a float.
options.splitbias = For variable learning rate, must be a function.

OUTPUT
e = Ensemble of trees, cell array
l = Loss, float

DATA
The Training Data and Training Labels must have the same length and should be structured as follows:

>>xr = [m x n] = [f11, f12, …, f1n; f21, …; …; fm1, …, fmn]
>>yr = [L1; L2; L3; …; Lm]
where f represents a feature data point and L represents the Labels.  Each row of the xr matrix should be an instance and the columns should be a feature of that instance.  The labels in yr, should be a column vector of length m.

LOSSFUNCTION
The user must also provide the "LossFunction".  The LossFunction should be structured as follows:

function [loss,gradient] = LossFunction(predictions,Labels)
…
end

The "LossFunction" (name doesn't matter) should include both the loss function and the gradient.  An example of a LossFunction can be found in MCL.m in the demo2 folder.

Once you have your LossFunction, Training Data, and Training Labels saved, you can now execute the gbrt program as seen in CODE STRUCTURE.  

CROSS VALIDATION - see demo2_CrossVal.m

>>[ENSEM,SCORE] = CrossVal(xv, @( p )metric(p,yv),e);
where
INPUTS
xv = Cross Validation Data
metric = function that evaluates the "test error" for your cross val data
e = the ensemble of trees produced by gbrt

OUTPUTS
ENSEM = Optimized ensemble of trees.
SCORE = Calculated from the metric that you provided.  Scores every ensemble of trees that was calculated.  We just threw that in.

TESTING

>>p = evalensemble(xe,ENSEM);
>>TestError = 1-sum(ye==p)/length(ye);
where
INPUTS
xe = Testing data,
ENSEM = The ensemble of trees that you achieved from CrossVal or from gbrt
ye = Testing Labels

OUTPUTS
p = predictions from the ensemble of trees. Data Structure and content may vary depending on the problem.  Hence calculating the TestError may also be different.
TestError = compare the labels to the predictions and see how well you did.

DEMOS
We provide 2 demos located in folders called demo1 and demo2.  Ensure that these demos have access to the library of functions that come with the program.

In demo1 we use yahoo web search engine data as an example of a regression problem. This demo includes the squared loss function and Testing.  No Cross Validation is used in this demo.

In demo2, we use the mnist data set for Digit Recognition, as a multi class classification example.  This demo includes the SoftMax Loss function,  CrossValidation, and Testing.

If you have any problems or encounter any bugs with the code please let us know.  Thanks!