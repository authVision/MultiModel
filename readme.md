#Vision team

Update date: 11-5-2015



##Example usage
in TrainScript:
>Create models for foxes

    modelsFox = [];
    parameters.dir = '../dataset_ImageNET/5';
    modelsFox = extractModels('../dataset_ImageNET/5', modelsFox);

>Create models for burgers

    modelsBurger = [];
    parameters.debugImgCount = 0;
    parameters.dir = '../dataset_ImageNET/2';
    modelsBurger = extractModels(parameters.dir, modelsBurger);

>Histogram of burger images with burger models

    burgersHist = getClassHist(modelsBurger,'../dataset_ImageNET/2');
    figure('name','burgers-modelsBurger')
    bar(burgersHist)

>Histogram of burger images with FOX models

    burgersHist_modelsFox = getClassHist(modelsFox,'../dataset_ImageNET/2');
    figure('name','burgers-modelsFox')
    bar(burgersHist_modelsFox)