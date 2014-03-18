%mv maker

function [data_mv,data,random_number_record] = mvMaker(data_mentah,k,presentase_mv)
    l_data = size(data_mentah); %menghitung panjang data
    jumlah_mv = floor(l_data(1,1)*presentase_mv/100); %menghitung jumlah mv
    temp_data = data_mentah;

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
end