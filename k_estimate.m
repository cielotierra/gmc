% K_Estimate function

% estimate the missing entries by 1,...,S-component mixtures
% the value of S is empirically determined
% each missing entry has S estimates
% final estimate is average of them

% information:
% B (data) = complete rows of A
% part 1 = initializes the missing entries by first obtaining the GMC of B,
%           then estimating the missing entries by EM_estimate
% A' = matrix with initial estimates
% part 2 = a loop that repeatedly computes GMC of A' and updates the
%           estimates

function [data_mv,dataFinal,kluster] = k_estimate(data,data_mv,kluster,k)
    
    l_datamv = size(data_mv);
    
    [myu,covmat,pk,C] = maximizationStep(data,kluster,k);
    
    nomor_mv = searchNan(data_mv);
    
    [data_mv] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv);
    
    l_data = size(data);
    
    dataFinal = data;
    
    for i=(l_data(1,1)+1):(l_data(1,1)+l_datamv(1,1))
        for j=1:l_data(1,2)
            dataFinal(i,j) = data_mv(i-(l_data(1,1)),j);
        end
    end
    
    status = 0;
    while(status~=1)
        [kluster] = kmeans(k,data);
        [myu,covmat,pk,C] = maximizationStep(dataFinal,kluster,k);
        temp = data_mv;
        [data_mv] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv);    
        for i=(l_data(1,1)+1):(l_data(1,1)+l_datamv(1,1))
            for j=1:l_data(1,2)
                dataFinal(i,j) = data_mv(i-(l_data(1,1)),j);
            end
        end
        if (isequal(temp,data_mv)==1)
            status=1;
        else
            status=0;
        end
    end
end