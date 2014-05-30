clc;
clear;

fprintf('Jumlah K');
k = input(' ');

fprintf('Presentasi Missing Value');
presentase_mv = input(' ');

filename = 'breast_cancer_wisconsin.xlsx';

[data_mentah] = readFile(filename);

[data_mv,data,random_number_record,data_mv_asli] = mvMaker(data_mentah,k,presentase_mv)

[kluster] = kmeans(k,data);

[nomor_mv] = searchNan(data_mv);

[data_full,data_mv_baru,covmat,myu]= k_estimate2(data_mentah,data,random_number_record,data_mv,kluster,k,nomor_mv);

%checking
