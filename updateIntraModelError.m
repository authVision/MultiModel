%% Function that updates errors induced by newly created models

function models = updateIntraModelError(models)

	for i=1:1:length(models.data)
		for j=1:1:length(models.data)
			models.data(i).errors{j}=mean(((models.data(i).C*models.data(j).trainIn)-models.data(j).trainOut).^2);
		end
	end

end