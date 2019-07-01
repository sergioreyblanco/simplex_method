# Implementation of the Simplex Method for lineal programming problems solving
Here is the implementation of the Simplex Method using R language and no additional libraries (as it was formulated by Dantzig in 1947).

The whole algorithm is implementated in the function `simplex`. It is divided in three well diferenced steps: the initializations of all the variables and data structures needed, the entry criterion and the exit criterion. The last two are repeated several times as the algorithm iterates in order to converge into a suitable solution.

The function takes as input parameters the following ones: the costs vector, the matrix of restrictions, the right sides vector, the base matrix and a special vector that contains the indexes of the matrix of restrictions that form a right solution. The first three parameters are given by a well-defined linear programming problem, but the last two must be created by the user in order to generate a feasible solution. Moreover, the user has to add some columns to the matrix of restrictions to contain the basic matrix created: `B`. The return value consists of a list with three components in which the first is the optimal solution (values of all the variables that the original objective function has), the second is the value obtained when the variables of the objective function are replaced with the array previously mentioned and the third are the indexes of the variables that form the solution obtained. No auxiliary functions were used.

Two examples are given (one is commented). Each of them consist of a cost vector, a matrix of restrictions and a right sides vector. Moreover, a basic matrix `B` containing the initial feasible solution and the indexes of that solution (relative to the matrix of restrictions) are also given. This initial solution is called a basic solution. In the examples artificial variables are added when needed using the arbitrary high value `M` (method of the Big M). A graphic representation of the solution of the first example `Example1` can be seen in the following figure:

![alt text](https://github.com/sergioreyblanco/simplex_method/blob/master/example1.PNG) 

An example of the execution of the code with the first example `Example1`is shown below:

![alt text](https://github.com/sergioreyblanco/simplex_method/blob/master/execution.PNG) 
