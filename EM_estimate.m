% EM_Estimate
% estimate missing entries row by row

% information:
% R = a row of matrix

% IS: Myu, Matriks yg udah dikluster, t, 

function [data_mv] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv)
% myu
% pk
% k
% data
% data_mv
% nomor_mv

    l_datamv = size(data_mv); %ukuran matriks missing value
     
    for i=1:l_datamv(1,1)
        for j=1:k
          R(i,j) = myu(j,nomor_mv(i,2));
        end
        temp1 = 0;
        temp2 = 0;
        for j=1:k
            %covtemp = cell2mat(covmat{j});
            covtemp = covmat{j};
            ftemp = hitungf(data_mv(i,:),myu(j),covtemp);
            temp1 = temp1 + R(i,j)*pk(j)*ftemp;
            temp2 = pk(j)*ftemp;
        end
        averageR = temp1/temp2;
        data_mv(i,nomor_mv(i,2)) = averageR;
    end
end