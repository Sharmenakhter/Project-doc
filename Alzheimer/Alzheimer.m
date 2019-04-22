%Read Alzheimer dataset
clc;
clear all;
close all;
path ='G:\M.Sc project doc\final project\OASIS_MR1_pngs\';
files=dir( strcat(path,'\*'));
k = 1;
for i=3:1:length(files)
    fullPath = strcat(path,files(i).name)
    fullPath = strcat(fullPath,'\')
    files1 = dir(fullPath)
    for j = 3:1:length(files1)
        
        fullFileName = strcat(fullPath,files1(j).name)
        I_orig = imread(fullFileName);
        featureVectorPos(k,1:18) = ExtractFeature(I_orig);
        k = k+1;
    end
end
y = ones(k-1,1);
featureVectorPositive = [featureVectorPos y];


%.......For training............%

path ='G:\M.Sc project doc\final project\OASIS_MR2_pngs\';
files2=dir( strcat(path,'\*'));
k = 1;
for i=3:1:length(files2)
    fullPath = strcat(path,files2(i).name)
    fullPath = strcat(fullPath,'\')
    files3 = dir(fullPath)
    for j = 3:1:length(files3)
        
        fullFileName = strcat(fullPath,files3(j).name)
        I_orig = imread(fullFileName);
        featureVectorNeg(k,1:18) = ExtractFeature(I_orig);
        k = k+1;
    end
end
y = zeros(k-1,1);
featureVectorNegative = [featureVectorNeg y];

%..............................................

dataset = [featureVectorPositive;featureVectorNegative];
TrainSet = [dataset(1:215,:);dataset(4161:4210,:)];
TestSet = [dataset(3950:4160,:);dataset(4311:4360,:)];

TrainSet = TrainSet(randperm(end),:);
TestSet = TestSet(randperm(end),:);

y_train = TrainSet(:,end);
x_train = [TrainSet(:,1) TrainSet(:,14:end-1)];
y_test = TestSet(:,end);
x_test = [TestSet(:,1) TestSet(:,14:end-1)];

svm = svmtrain(x_train,y_train);
y_pred = svmclassify(svm,x_test);
acc1 = y_test-y_pred;
%a = 111
correct=0;

%Accuracy and Sensitivity Calculation
for i=1:length(acc1)
   if acc1(i)==0
       correct=correct+1;
   end
end
accuracy = correct/size(acc1,1)

tp=0;tn=0;fp=0;fn=0;
for j=1:length(acc1)
   if y_test(j)==1
        if y_pred(j)==1
            tp=tp+1;
        elseif y_pred(j) == 0
            fn=fn+1;
        end
   else
       if y_pred(j) ==1;
           fp=fp+1;
       elseif y_pred(j)==0;
           tn=tn+1;
       end
   end
end
tp,tn,fp,fn
sens = tp/(tp+fn)
spec=tn/(fp+tn)
