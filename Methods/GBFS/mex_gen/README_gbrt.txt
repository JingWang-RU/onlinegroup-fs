README
Program name: gbrt.m

Version 1.0 
Ryan Talk and Mrunal Desai 

Contact Info: ryan.a.talk@gmail.com, munudesi11@gmail.com


Release Date:

Things To Do:
1. Make binaries of mex functions.
2. Make sure code runs in Windows, Linux, …
3. Fix data in the Demos -- Only use a portion of data instead of all of it.
4. Add "AddToPath" commands to the beginning of the Demos
5. Add help text in every function
6. Add more loss functions to the library
7. Organize functions into folders?

INTRODUCTION
This function uses gradient boosted regression trees to relate the training Data to the training labels.  It can be used for regression, classification, multi class regression, multi-class classification, and any model that uses gradient boosted regression trees.  

USE: (See Demos)
1.  Load Data
Specify Options
2.  Run the gbrt program
Optional: Cross Validate
3. Test

CODE STRUCTURE - gbrt.m

>>options.ntrees = 100
>>[e,l] = gbrt(xr,@(p )LossFunction(yr,p),options);
>>

where
INPUT
xr = Training Data
yr = Training Labels
p = variable for predicitions

OPTIONS
There are 4 different options that you can specify: 
options.ntrees = Number of trees in ensemble, integer
options.depth = The depth of the tree, integer
options.learningrate = learning rate, float
options.splitbias = Variable learning rate. ---What should split bias be?

OUTPUT
e = Ensemble of trees, cell array
l = Loss, float

DATA
The Training Data and Training Labels must have the same length and should be structured as follows:

>>xr = [m x n] = [f11, f12, …, f1n; f21, …; …; fm1, …, fmn]
>>yr = [L1; L2; L3; …; Lm]
where f represents a feature data point and L represents the Labels.  Each row of the xr matrix should be an instance and the columns should be a feature.  The labels, yr, should be a column vector of length n.

LOSSFUNCTION
The user must also provide the "LossFunction".  The LossFunction should be structured as follows:

function [loss,gradient] = LossFunction(predictions,Labels)
…
end

The "LossFunction" should include both the loss function and the gradient.  An example of a LossFunction can be found in MCL.m in the demo2 folder.

Once you have your LossFunction, Training Data, and Training Labels saved, you can now execute the gbrt program as seen in CODE STRUCTURE.  

CROSS VALIDATION AND TESTING
After execution, we also provide a cross validation code to help generalize your trees (See CrossVal.m. in the demo2 folder)  You can also use the program evalensemble.m to test your trees.

DEMOS
We provide 2 demos located in folders called demo1 and demo2. 

In demo1 we use yahoo web search engine data and the squared loss function.  We create 100 trees and then find the test error using the testing data.  No Cross Validation is used in this demo.

In demo2, we use the mnist data set, Digit Recognition, for a multi class classification example.  This demo includes the SoftMax Loss function,  CrossValidation, and Testing.

If you have any problems or encounter any bugs with the code please let us know.  Thanks!