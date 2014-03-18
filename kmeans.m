function [kluster] = kmeans(k,data)
  
%{
    i = 1;
    
    while(i<=jumlah_mv)
        temp = randi(l_data(1));
        if(i==1)
            random_number_record(i)=temp;
            i = i + 1;
        else
            for j=1:i-1
                if(random_number_record(j)==temp)
                    cekstatus = 1;
                    break;
                else
                    cekstatus = 0;
                end
            end
            if(cekstatus == 1)
                i = i;
            else
                random_number_record(i)=temp;
                i = i + 1;
            end
        end
    end
    
    index_mv = length(random_number_record);
    status = 0;
    cek = [1 l_data(2)];
    data = zeros(cek);
    data_mv = data;
    
    for i=1:l_data(1)
        cekstatus = 0;
        for j=1:index_mv
            if(random_number_record(j)==i)
                cekstatus = 1;
                break;
            end
        end
        if(cekstatus==1)
            ix_mv = size(data_mv);
            temp = randi(l_data(2));
            if(sum(data_mv)==0)
                data_mv(ix_mv(1,1),:)=temp_data(i,:);
                data_mv(ix_mv(1,1),temp)=NaN;                
            else
                data_mv(ix_mv(1,1)+1,:)=temp_data(i,:);
                data_mv(ix_mv(1,1)+1,temp)=NaN;
            end
        else
            ix = size(data);
            if(sum(data)==0)
                data(ix(1,1),:)=temp_data(i,:);
            else
                data(ix(1,1)+1,:)=temp_data(i,:);
            end
        end
    end
%}
    l_data = size(data); %Length Data yg tidak memiliki missing value
    
    for i=1:k
        random_number(i)=randi(l_data(1,1)); %belum ada pengecekan nomor double
    end
    
    for i=1:k
        for j=1:l_data(1,2)
            titik_random(i,j) = data(random_number(i),j);
        end
    end
    
    status = 0;
    cek = 0;

    while status==0

        cek = cek + 1; %buat cek jumlah iterasi
    
        for g=1:l_data(1,1) %untuk iterasi data
            for i=1:k %untuk iterasi titik_random
                titik(g,i)=0;
                    for j=1:l_data(1,2) %untuk iterasi penjumlahan
                    titik(g,i) = titik(g,i) + (data(g,j)-titik_random(i,j))^2;
                    end
                titik(g,i) = sqrt(titik(g,i));
        	end
        end

        %pengecekan cluster
        for i=1:l_data(1,1)
            temp = titik(i,1);
            kluster(i) = 1;
            for j=2:k
                if(titik(i,j)<temp)
                    temp = titik(i,j);
                    kluster(i) = j;
                end
            end
        end

        for i=1:k
            for j=1:l_data(1,2)
                temp(i,j)=0;
            end
            jumlah_anggota(i)=0;
        end

        %Perhitungan centroid baru
        for i=1:l_data(1,1)
            for j=1:l_data(1,2)
                temp(kluster(i),j) = temp(kluster(i),j) + data(i,j);
            end
            jumlah_anggota(kluster(i)) = jumlah_anggota(kluster(i)) + 1;
        end

        for i=1:k
            for j=1:l_data(1,2)
                temp2(i,j) = temp(i,j)/jumlah_anggota(i);
            end
        end

        %pengecekan konvergen atau tidak

        if (temp2~=titik_random)
            for i=1:k
                for j=1:4
                    titik_random(i,j) = temp2(i,j);
                end
            end
            status = 0; 
        else
            status = 1;
        end
    end    
end




