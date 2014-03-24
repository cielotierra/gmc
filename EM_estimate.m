% EM_Estimate
% estimate missing entries row by row

% information:
% R = a row of matrix

% IS: Myu, Matriks yg udah dikluster, t, 

function [data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv)
% myu
% pk
% k
% data
% data_mv
% nomor_mv
    l_datamv = size(data_mv);
    data_mv_baru = double(data_mv);
    phi = 3.14;

    for i=1:l_datamv(1,1)
        for j=1:k
            R(i,j) = myu(nomor_mv(i),j);
        end
        temp_data = data_mv(i,:);
        for j=1:k
            temp_data(nomor_mv(i))=R(i,j);
            
            temp = (covmat{j});
            temp_inv = pinv(temp);            
            
            f(j) = (exp( -(1/2)*(temp_data-transpose(myu(:,j)))*temp_inv*(transpose(temp_data)-myu(:,j)) )) / ( sqrt(det(2*phi*temp)));
        end
        penyebut = 0;
        pembilang = 0;
        for j=1:k
            penyebut = penyebut + (R(i,j)*pk(k)*f(j));
            pembilang = pembilang + (pk(k)*f(j));
        end
        R_average(i) = penyebut/pembilang;
    end
    
    for i=1:(l_datamv(1,1))
        data_mv_baru(i,(nomor_mv(i)))=(R_average(i));
    end
end