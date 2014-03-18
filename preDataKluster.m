function [C] = preDataKluster(Data,Kluster,k)

l_data = size(Data);

for i=1:k
    C{i} = zeros(1,l_data(2));
end

for i=1:l_data(1,1)
    temp_matriks = C{Kluster(i)};
    temp = size(temp_matriks);
    temp_matriks(temp(1,1)+1,:) = Data(i,:);
    C{Kluster(i)} = temp_matriks;
end
end