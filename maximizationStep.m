%Gaussian Mixture
function [myu,covmat,pk,C] = maximizationStep(data,kluster,k)

    %Perhitungan Myu
    l_data = size(data);
    sz = [k,l_data(1,2)];
    temp = zeros(sz);

    C = preDataKluster(data,kluster,k);

    for i=1:k
        myu(i,:) = mean(C{i});
    end

    myu = transpose(myu);

%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

%Perhitungan covarian

    for i=1:k
        temp_jumlah{i} = zeros(l_data(1,2),l_data(1,2));
    end

    for i=1:l_data(1,1)
        temp = ( (transpose (data(i,:) ) - myu(:,kluster(i)) )*(data(i,:) - transpose( myu(:,kluster(i)) ) ) );
        temp_jumlah{kluster(i)} = cell2mat(temp_jumlah(kluster(i))) + temp;
    end

    for i=1:k
        temp = 1/length(C{i})*temp_jumlah{i};
        covmat{i} = deal(temp);
    end
   
%-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

%perhitungan peluang setiap kluster

for i=1:k
    temp_jumlah = size(C{i});
    pk(i) = temp_jumlah(1,1)/l_data(1,1);
end