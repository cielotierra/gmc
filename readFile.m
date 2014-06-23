function [data_mentah,l] = readFile(filename)
    temp = xlsread(filename);
    l = size(temp);
    panjang_kolum = l(1,2) - 1;
    for i=1:l(1,1)
    	for j=2:panjang_kolum
    		data_mentah(i,j-1)=temp(i,j);
    	end
    end
end