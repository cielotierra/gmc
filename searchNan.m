%searching record NaN

function [nomor_mv] = searchNan(data_mv)
    %search number atribute
    
    l_datamv = size(data_mv);
    
    for i=1:l_datamv(1,1)
        nomor_mv(i,1)=i;
        for j=1:l_datamv(1,2)
            if (isnan(data_mv(i,j))==1)
                nomor_mv(i,2) = j;
            end
        end
    end
end