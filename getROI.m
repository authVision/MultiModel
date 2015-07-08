function roi = getROI(image, countFailedROI)
	%
	errorMapTemp = image.errorMap;
	f=ones(10,10);
	errorMapTemp(~image.noClassified)=0;
	r=imfilter(errorMapTemp,f);

	global parameters;
	scanOffset = ceil(parameters.maskScanSize/2);

	for i=1:countFailedROI
		maxError = max(max(r));
		r(r==maxError) = 0;
	end
	
	[roi.centerX,roi.centerY]=find(r==max(max(r)),1,'first');

	if (roi.centerX<scanOffset)
		roi.centerX=roi.centerX+scanOffset;
	elseif (roi.centerX>(size(errorMapTemp,1)-scanOffset))
		roi.centerX=roi.centerX-scanOffset;
	end
	if(roi.centerY<scanOffset)
		roi.centerY=roi.centerY+scanOffset;
	elseif (roi.centerY>(size(errorMapTemp,1)-scanOffset))
		roi.centerY=roi.centerY-scanOffset;
	end

	%centered
	idx1 = (image.x>=roi.centerX-scanOffset & image.x<=scanOffset+roi.centerX)&(image.y>=roi.centerY-scanOffset & image.y<=scanOffset+roi.centerY);  

	roi.in = image.in(:,idx1);
	roi.out = image.out(:,idx1);

end