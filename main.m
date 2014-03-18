clc;
clear;

fprintf('Jumlah K');
k = input(' ');

fprintf('Presentasi Missing Value');
presentase_mv = input(' ');

filename = 'SPECT.xlsx';

[data_mentah] = readFile(filename);

[data_mv,data,random_number_record] = mvMaker(data_mentah,k,presentase_mv)

[kluster] = kmeans(k,data);

[myu,covmat,pk,C] = maximizationStep(data,kluster,k);

disp (myu);
disp (covmat);
disp (pk);
disp (C);

[t] = expectationStep(data,myu,covmat,pk,k);

[nomor_mv] = searchNan(data_mv);

[data_mv,dataFinal,kluster] = k_estimate(data,data_mv,kluster,k);