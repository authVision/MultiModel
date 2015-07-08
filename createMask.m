function [ mask ] = createMask(preset)
	%CREATEMASK Summary of this function goes here
	%   Detailed explanation goes here
	if(preset == 1)
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		mask = ones(5,5);
		mask = [mask  2*ones(5,2)];
	elseif(preset == 2)
		% 1 1 1 1 1 2
		% 1 1 1 1 1 2
		% 1 1 1 1 1 2
		% 1 1 1 1 1 2
		% 1 1 1 1 1 2
		% 2 2 2 2 2 2
		mask = ones(5,5);
		mask = [mask  2*ones(5,1)];
		mask = [mask ; 2*ones(1,6)];
	elseif(preset == 3)
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 2 2 2 2 2 2 2
		mask = ones(5,5);
		mask = [mask  2*ones(5,2)];
		mask = [mask; 2*ones(1,7)];
	elseif(preset == 4)
		% 1 1 1 2 2
		% 1 1 1 2 2
		% 1 1 1 2 2
		% 2 2 2 2 2
		mask = ones(3,3);
		mask = [mask  2*ones(3,2)];
		mask = [mask; 2*ones(1,5)];
	elseif(preset == 5)
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		% 1 1 1 1 1 2 2
		mask = ones(5,5);
		mask = [mask  2*ones(5,5)];
	elseif(preset == 6)
		% 16 -> 3
		% 1 1 1 1 2
		% 1 1 1 1 2
		% 1 1 1 1 2
		% 1 1 1 1 0
		mask = ones(4, 4);
		mask = [mask 2*ones(4,1)];
		mask(4,5) = 0;
	elseif(preset == 7)
		% 12 -> 3
		% 1 1 1 1 2
		% 0 0 1 1 2
		% 0 1 0 1 2
		% 1 0 0 1 0
		mask = diag(ones(1, 4));
		mask = flipdim(mask,1);
		% mask = zeros(4,4);
		mask(1,:) = 1;
		mask(:,4) = 1;
		mask = [mask 2*ones(4,1)];
		mask(4,5) = 0;

	elseif(preset==12)
		% hadoulos
		
		%1 1 1 0
		%1 1 1 0
		%1 1 1 0
		%0 0 0 2
		mask=zeros(4,4);
		mask(4,4)=2;
		mask(1:3,1:3)=1;

	end % end ifs

	% repeat mask accross third axis (z) (colors)
	mask=repmat(mask,[1 1 3]);
end

