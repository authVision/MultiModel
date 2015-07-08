%% Function that updates image and models structures by testing

function [image, models] = findNewModels(image, models, filename, className)

    maxUnclassified=0.2*numel(image.noClassified);
    modelCount=length(models.data);
    fprintf('modelCount before %d \n', modelCount);
    loopCount = 1;
    countFailedROI = 0;
    fprintf('New image models\n');
    while( (sum(sum(image.noClassified)) > maxUnclassified) )
        % fprintf('loop %d, unClass %d, maxUnclassified %d \n', loopCount, sum(sum(image.noClassified)), maxUnclassified  );
        loopCount = loopCount + 1;
        roi=getROI(image, countFailedROI);
        tempModel=trainNewModel(roi);
        

        tempModelCount=modelCount+1;
        errorMap=getErrorMap(image,tempModel);
        image=updateClassifyMatrix(image,errorMap,tempModelCount);

        if(sum(sum(image.classID == tempModelCount))>0 )
            modelCount = tempModelCount;
            fprintf('%d,',tempModelCount);
            tempModel.modelId = tempModelCount;
            tempModel.trainFileName = filename;
            
            % x -> row, y -> column (eeehm meh)
            % mark if trained insided the bounding box
            tempModel.trainX = roi.centerX;
            tempModel.trainY = roi.centerY;
            if(tempModel.trainX>=image.boundingBox(1) && tempModel.trainX<=image.boundingBox(2) && tempModel.trainY>=image.boundingBox(3) && tempModel.trainY<=image.boundingBox(4) )
                tempModel.boundingBox = 1;
            else
                tempModel.boundingBox = 0;
            end
            % keeping className, classId (normally only classId required,
            % but className useful for debugging
            tempModel.className = className;
            if( isKey(models.classIdMap,className) )
                tempModel.classId = models.classIdMap(className);
            else
                tempModel.classId = length(models.classIdMap)+1;
                models.classIdMap(className) = tempModel.classId;
            end
            models.data=[models.data tempModel];
            countFailedROI = 0;
        else
            fprintf('__,');
            countFailedROI = countFailedROI + 1;
            % fprintf('countFailedROI %d \n', countFailedROI);
        end
        if(countFailedROI > 10)
            fprintf('break\n');
            break
        end
    end
    modelCount=length(models.data);
    fprintf('ModelCounter after %d \n', modelCount);

    % debug: save image.classID imagesc plot
    global parameters;
    parameters.debugImgCount = parameters.debugImgCount +1;
    set(gcf,'Visible','Off')
    imagesc(image.classID)
    fig=gcf;
    
    parts = strsplit(filename, '/');
    debugDir = ['./debug/' parts{end-1}];
    debugFilename = parts{end};
    % fix: matlab can't output 'JPEG' (original filenames extension)
    debugFilename = [debugFilename(1:end-4) 'jpg'];
        
    if( exist(debugDir, 'dir' ) == 0 )
        mkdir(debugDir);
    end
    
    saveas(fig,[debugDir '/' debugFilename])
end