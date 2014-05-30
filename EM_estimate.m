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

    for i=1:l_datamv(1,1)
        temp_record = nomor_mv(i);
        for j=1:k
            %hitung pdf per-kluster
            temp_data(j,:) = double(data_mv(i,:));
            temp_data(j,temp_record)=double(myu(temp_record,j));
            f(i,j) = double(pdf_estimate(temp_data(j,:),myu(:,j),covmat{j},k));
        end

        %Hitung Weight Average
        %pembilang
        pembilang = 0;
        penyebut = 0;
        for j=1:k
            pembilang = pembilang + myu(temp_record,j)*pk(j)*f(i,j);
            penyebut = penyebut + pk(j)*f(i,j);
        end
        %{disp('pembilang');
        disp(pembilang);
        disp('penyebut');
        disp(penyebut);
        %}
        R(i) = pembilang/penyebut;
        %disp(R(i));
        data_mv_baru(i,temp_record)=R(i);
    end
end