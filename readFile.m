function [data_mentah] = readFile(filename)
    temp = xlsread(filename);
    l = size(temp);
    for i=1:l(1,1)
    	for j=2:l(1,2)-1
    		data_mentah(i,j-1)=temp(i,j);
    	end
    end
end