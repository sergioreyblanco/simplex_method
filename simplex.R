

############
### Example 1
############

  #Cost vector
  c <- c(-8, -4, 0, 0, 0)
  
  #Matrix of restrictions
  A<-matrix(nrow=3,ncol=5)
  A[1,] <- c(5, -2, 1, 0, 0)
  A[2,] <- c(8, -2, 0, 1, 0)
  A[3,] <- c(8,  1, 0, 0, 1)
  
  #Right sides
  b<-c(0,1,2)
  
  #Initial solution
  B<-matrix(nrow=3,ncol=3)
  B[1,] <- c(1, 0, 0)
  B[2,] <- c(0, 1, 0)
  B[3,] <- c(0, 0, 1)
  solIndexes <- c(3,4,5)



############
### Example 2
############

  #Cost vector
  c <- c(7, 1, 5, -4, 0, 0, M, M)
  
  #Matrix of restrictions
  A<-matrix(nrow=3,ncol=8)
  A[1,] <- c(-2, 2, -6, -6, 0, 0, 1, 0)
  A[2,] <- c(-4, 2,  5,  1,-1, 0, 0, 1)
  A[3,] <- c(-2,-1, -1, -7, 0, 1, 0, 0)
  
  #Right sides
  b<-c(8,6,2)
  
  #Initial solution
  B<-matrix(nrow=3,ncol=3)
  B[1,] <- c(1, 0, 0)
  B[2,] <- c(0, 1, 0)
  B[3,] <- c(0, 0, 1)
  solIndexes <- c(7,8,6)
  

############
### Example 3
############

  #Cost vector
  c <- c(7, 1, 5, -4, 0, 0, M, M)
  
  #Matrix of restrictions
  A<-matrix(nrow=3,ncol=8)
  A[1,] <- c(-2, 2, -6, -6, 0, 0, 1, 0)
  A[2,] <- c(-4, 2,  5,  1,-1, 0, 0, 1)
  A[3,] <- c(-2,-1, -1, -7, 0, 1, 0, 0)
  
  #Right sides
  b<-c(8,6,2)
  
  #Initial solution
  B<-matrix(nrow=3,ncol=3)
  B[1,] <- c(1, 0, 0)
  B[2,] <- c(0, 1, 0)
  B[3,] <- c(0, 0, 1)
  solIndexes <- c(7,8,6)


  
###############
### Implementation
###############

  simplex <- function(c,A,b,B,solIndexes){
    i = 0
    j = 1
    sum = 0
    max = -1
    min = 1000000
    entryVariable = -1
    exitVariable = -1
    entryVariable.relative = -1
    exitVariable.relative = -1
    cb <- c()
    entryCriterion <- c()
    
    #Step 1: initialization
    invB=solve(B)               #inverse of matrix B
    xb <- invB %*% b            #initial solution array
    for(i in solIndexes){       #cb array
      cb <- c(cb, c[i])
    }
    cb[is.na(cb)] <- 0
      
    noSolIndexes <- c()         #indexes of the candidate variables
    for(i in 1:5){
      if(!i %in% solIndexes){
         noSolIndexes <- c(noSolIndexes,i)
       }
    }
    
    #the algorithm iterates
    while(TRUE){
      #Step 2: entry criterion  
      for(i in noSolIndexes){     #criterion to decide which variable is going to enter in the solution is obtained
        ac <- A[,i]
        y  <- invB %*% ac
  
        candidateVariableCost = c[i]
        if(is.na(candidateVariableCost))  candidateVariableCost = 0
        entryCriterion <- c(entryCriterion, cb %*% y - candidateVariableCost)
      }
      
      for(i in entryCriterion){  #maximum (variable that is going to enter is obtained)
        if(i<=0){
          sum = sum+1
        }
        else if(i > max){
          max = i
          entryVariable.relative = j
        }
        j = j + 1
      }
  
      if(sum == length(entryCriterion)){ #an optimal solution has been found
        print("[ Optimal solution ]")
        break
      }
      
      entryVariable = noSolIndexes[entryVariable.relative] #the index of the entr variable is obtained 
                                                            
      
  
      #Step 3: exit criterion
      y <- c()
      sum = 0
      j=1
      y <- invB %*% A[,entryVariable]
      for(i in y){
        if(i <= 0){
          sum = sum + 1
        }else if(xb[j]/i < min){
          min = xb[j]/i
          exitVariable.relative = j
        }
        j = j + 1
      }
      
      exitVariable = solIndexes[exitVariable.relative]
  
      
      if(sum == length(A[,entryVariable])){
        return("[ Unbounded problem ]")
      }
      
      
      #Step 4: solution is recalculated
      B[,exitVariable.relative] = A[,entryVariable]
      
      invB=solve(B)               #inverse of the B matrix
      xb <- invB %*% b            #solution is obtained
      solIndexes[exitVariable.relative] = entryVariable 
      noSolIndexes[which(noSolIndexes==entryVariable)] = exitVariable
      cb[exitVariable.relative] = c[entryVariable]
      if(is.na(cb[exitVariable.relative]))  cb[exitVariable.relative] = 0
      
      #temporal variables are cleaned
      i = 0
      j = 1
      sum = 0
      max = -1
      min = 1000000
      entryVariable = -1
      exitVariable = -1
      entryVariable.relative = -1
      exitVariable.relative = -1
      entryCriterion <- c()
    }
    
    #return of values
    z = cb[i]%*%xb[i]
    return(list("Values of the variables" = xb, "Minimun cost" = z, "Base" = solIndexes))
  }



  
############
### Execution
############

  simplex(c,A,b,B,solIndexes)
  
  
