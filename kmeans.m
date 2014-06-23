function [kluster] = kmeans(k,data)
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

    disp('sebelum iterasi');

    while (status==0)
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

        disp('Pengecekan Konvergen');

        %pengecekan konvergen atau tidak

        if(cek==100)
            break;
        end

        if (temp2~=titik_random)
            for i=1:k
                for j=1:l_data(1,2)
                    titik_random(i,j) = temp2(i,j);
                end
            end
            status = 0; 
        else
            status = 1;
        end
    end    
end




