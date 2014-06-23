%searching record NaN

function [nomor_mv,l_datamv] = searchNan(data_mv)
    %search number atribute
    
    l_datamv = size(data_mv);
    
    for i=1:l_datamv(1,1)
        for j=1:l_datamv(1,2)
            if (isnan(data_mv(i,j))==1)
                nomor_mv(i) = j;
            end
        end
    end
end