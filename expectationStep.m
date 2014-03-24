%Expectation Step

function [t] = expectationStep(data,myu,covmat,pk,k)
    l_data = length(data);
    phi = 3.14;

    for i=1:l_data(1,1)
        for j=1:k
            temp = (covmat{j});
            temp_inv = pinv(temp);
            %disp(temp_inv);
            %f(j) = (exp( (-1/2)*(data(i,:)-transpose(myu(:,j)))*temp*(transpose(data(i,:))-myu(:,j)) )) / ( sqrt(det(2*phi*temp)) );
            f(j) = (exp( -(1/2)*(data(i,:)-transpose(myu(:,j)))*temp_inv*(transpose(data(i,:))-myu(:,j)) )) / ( sqrt(det(2*phi*temp)));
        end      
    end    
end