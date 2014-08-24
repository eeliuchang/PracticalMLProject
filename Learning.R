##The goal of your project is to predict the manner in which 
## they did the exercise. This is the "classe" variable in 
##the training set. 
##You may use any of the other variables 
##to predict with. You should create a report describing 
##how you built your model, how you used cross validation, 
##what you think the expected out of sample error is,
##and why you made the choices you did. 
##You will also use your prediction model to 
##predict 20 different test cases. 

training <- read.csv("pml-training.csv")
testing <- read.csv("pml-testing.csv")



head(training)
names(training)
library(ggplot2); library(caret);library(mlbench);set.seed(333);

inTrain <- createDataPartition(y=training$classe, p=0.75,list=FALSE)
tr <- training[inTrain,]
cv <- training[-inTrain,]

ctrl <- trainControl(method="repeatedcv",repeats=3,classProbs=TRUE)
modelFit <- train(classe~., data=tr,method="pls",tuneLength=15, trControl=ctrl,metric="ROC",preProcess=c("center","scale"))
confusionMatrix(cv$classe, predict(modelFit, cv))
