# COForest demo code for paper 863
# Datasetscs
Two demo datasets are located in the Data folder, i.e., CS, HF.
# Code information
All codes are written in Matlab. The functionality of each section is as follows:
The Metrics folder contains code for evaluating clustering performance.  The COForest_alg folder contains the code details of the COForest algorithm.
The initialize.m file initialize \mathbf{Q}. The COForest_main.m file is the main algorithm of the COForest algorithm and implements the outer loop of the COForest algorithm.
The ICOF.m file implements the inner loop function of the COForest algorithm. The Order_Tree_construct.m file and the TreeStruct_DistMtx.m file implement the Order forest construct and the functions of constructing the tree distance matrix, respectively.
Finally, the Execute_Clustering.m file is the execution file of the entire COForest algorithm on the given data set. 
# How to run
	Just add all files to the run path, and run the Execute_Clustering.m file, the results will be seen in the command line window.
