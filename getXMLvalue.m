function [value] = getXMLvalue(filename, property)
% GETXMLVALUE Get XML value from input filename
% valid input properties: xmin, xmax, ymin, ymax
% -----
% NOTE: xmin,xmax: to crop or whatever in matlab
% 		imageCropped = imageOriginal(ymin:ymax, xmin:max)
% 		reverse order!

    DOMnode = xmlread(filename);
	items = DOMnode.getElementsByTagName(property);
    item = items.item(0);
    value = item.getFirstChild.getData;
    % +1 cause i think it returns zero based coordinates
    value = str2num(value) + 1;
end