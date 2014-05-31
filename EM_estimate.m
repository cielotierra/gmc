% EM_Estimate
% estimate missing entries row by row
function [data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv)
% myu = mean
% pk = probability of cluster
% k = number of cluster
% data = original data
% data_mv = data with missing value (NaN)
% nomor_mv = nomor atribut yang memiliki missing value
    l_datamv = size(data_mv);
    data_mv_baru = double(data_mv);

    for i=1:l_datamv(1,1)
        temp_record = nomor_mv(i);
        for j=1:k
            %hitung pdf per-kluster
            temp_data(j,:) = double(data_mv(i,:));
            temp_data(j,temp_record)=double(myu(temp_record,j));
            f(i,j) = double(pdf_estimate(temp_data(j,:),myu(:,j),covmat{j},k));
        end

        %Hitung Weight Average
        pembilang = 0;
        penyebut = 0;
        for j=1:k
            pembilang = pembilang + myu(temp_record,j)*pk(j)*f(i,j);
            penyebut = penyebut + pk(j)*f(i,j);
        end
        R(i) = pembilang/penyebut;
        data_mv_baru(i,temp_record)=R(i);
    end
end