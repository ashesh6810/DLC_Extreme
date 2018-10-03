import numpy as np
from numpy import genfromtxt

test_y=np.load('test_labels_40ensemble_4classes_anomaly_forTRUEandFalse_matrix_bicubic.npy')

prediction=genfromtxt('prediction_TRUE_andFalse4layers_65perxav.csv', delimiter=',')


for i in range(0,np.size(prediction,0)):
 x=np.argmax(prediction[i,:])
 prediction[i,x]=1
 
for i in range(0,np.size(prediction,0)):
 for j in range(0,np.size(prediction,1)):
   if (prediction[i,j]<>1):
    prediction[i,j]=0

  
class1=0
class2=0
class3=0
class4=0  
class5=0  
for i in range(0,np.size(test_y,0)):
    if (test_y[i,0]==1):
        class1=class1+1
    if (test_y[i,1]==1):
        class2=class2+1
    if (test_y[i,2]==1):
        class3=class3+1
    if (test_y[i,3]==1):
        class4=class4+1
    if (test_y[i,4]==1):
        class5=class5+1
print ('class1=')
print (class1)

print ('class2=')
print (class2)

print ('class3=')
print (class3)

print ('class4=')
print (class4)

print('class5=')
print(class5)

markov_matrix=np.zeros((5,5))





for i in range(0,np.size(test_y,0)):
 if (test_y[i,0]): 
  if(prediction[i,0]==1):
   markov_matrix[0,0]=markov_matrix[0,0]+1
  elif(prediction[i,1]==1):
   markov_matrix[0,1]=markov_matrix[0,1]+1
  elif((prediction[i,2]==1)):
   markov_matrix[0,2]=markov_matrix[0,2]+1
  elif((prediction[i,3]==1)):
   markov_matrix[0,3]=markov_matrix[0,3]+1
  elif((prediction[i,4]==1)):
   markov_matrix[0,4]=markov_matrix[0,4]+1
 if (test_y[i,1]):
  if(prediction[i,1]==1):
   markov_matrix[1,1]=markov_matrix[1,1]+1
  elif(prediction[i,0]==1):
   markov_matrix[1,0]=markov_matrix[1,0]+1
  elif((prediction[i,2]==1)):
   markov_matrix[1,2]=markov_matrix[1,2]+1
  elif((prediction[i,3]==1)):
   markov_matrix[1,3]=markov_matrix[1,3]+1
  elif((prediction[i,4]==1)):
   markov_matrix[1,4]=markov_matrix[1,4]+1
 if (test_y[i,2]):
  if(prediction[i,2]==1):
   markov_matrix[2,2]=markov_matrix[2,2]+1
  elif(prediction[i,0]==1):
   markov_matrix[2,0]=markov_matrix[2,0]+1
  elif((prediction[i,1]==1)):
   markov_matrix[2,1]=markov_matrix[2,1]+1
  elif((prediction[i,3]==1)):
   markov_matrix[2,3]=markov_matrix[2,3]+1 
  elif((prediction[i,4]==1)):
   markov_matrix[2,4]=markov_matrix[2,4]+1
 if (test_y[i,3]):
   if(prediction[i,3]==1):
    markov_matrix[3,3]=markov_matrix[3,3]+1
   elif(prediction[i,0]==1):
    markov_matrix[3,0]=markov_matrix[3,0]+1
   elif((prediction[i,1]==1)):
    markov_matrix[3,1]=markov_matrix[3,1]+1
   elif((prediction[i,2]==1)):
    markov_matrix[3,2]=markov_matrix[3,2]+1
   elif((prediction[i,4]==1)):
    markov_matrix[3,4]=markov_matrix[3,4]+1
 if (test_y[i,4]):
   if(prediction[i,4]==1):
    markov_matrix[4,4]=markov_matrix[4,4]+1
   elif(prediction[i,0]==1):
    markov_matrix[4,0]=markov_matrix[4,0]+1
   elif((prediction[i,1]==1)):
    markov_matrix[4,1]=markov_matrix[4,1]+1
   elif((prediction[i,2]==1)):
    markov_matrix[4,2]=markov_matrix[4,2]+1
   elif((prediction[i,3]==1)):
    markov_matrix[4,3]=markov_matrix[4,3]+1

print('TRANSITION MATRIX')
print(markov_matrix) 
