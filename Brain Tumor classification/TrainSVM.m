function [xdata, group] = TrainSVM(handles)
myFolder = 'C:\Users\shrette\Desktop\Matlab\Benign\';
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s',myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);

%... Reading first image
baseFileName = jpegFiles(1).name;
fullFileName = fullfile(myFolder, baseFileName);
fprintf(1,'Now reading %s\n', fullFileName);
imageArray = imread(fullFileName);
%imshow(imageArray);
featureMatrix1 = Master(imageArray,handles);
%.............
for k = 2:length(jpegFiles)
    baseFileName = jpegFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1,'Now reading %s\n', fullFileName);
    imageArray = imread(fullFileName);
    %imshow(imageArray);
    dataRow = Master(imageArray,handles);
    featureMatrix1 = [ featureMatrix1 ; dataRow ];
    drawnow;
end
label1 = ones(length(jpegFiles),1);
featureMatrix1 = [featureMatrix1 label1];
%..........................
%...........................

myFolder = 'C:\Users\shrette\Desktop\Matlab\Malignant\';
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s',myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);

%... Reading first image
baseFileName = jpegFiles(1).name;
fullFileName = fullfile(myFolder, baseFileName);
fprintf(1,'Now reading %s\n', fullFileName);
imageArray = imread(fullFileName);
%imshow(imageArray);
featureMatrix2 = Master(imageArray,handles);
%.............
for k = 2:length(jpegFiles)
    baseFileName = jpegFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1,'Now reading %s\n', fullFileName);
    imageArray = imread(fullFileName);
 %   imshow(imageArray);
    dataRow = Master(imageArray,handles);
    featureMatrix2 = [ featureMatrix2 ; dataRow ];
    drawnow;
end
label2 = ones(length(jpegFiles),1)*2 ;
featureMatrix2 = [featureMatrix2 label2];

%..........

featureMatrix = [ featureMatrix1; featureMatrix2 ];

featureMatrix = featureMatrix(randperm(size(featureMatrix,1)),:);
%.....train

xdata = featureMatrix(:,1:end-1);
group = featureMatrix(:,end);

end