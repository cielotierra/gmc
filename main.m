clc;
clear;

fprintf('Jumlah K');
k = input(' ');

fprintf('Presentasi Missing Value');
presentase_mv = input(' ');

filename = 'SPECT.xlsx';

[data_mentah] = readFile(filename);

[data_mv,data,random_number_record,data_mv_asli] = mvMaker(data_mentah,k,presentase_mv)

[kluster] = kmeans(k,data);

[nomor_mv] = searchNan(data_mv);

[data_full,data_mv_baru,covmat,myu]= k_estimate2(data_mentah,data,random_number_record,data_mv,kluster,k,nomor_mv);

%checking
%TEMPORARY
hasil_akurasi = data_mv_asli - data_mv_baru;
disp (hasil_akurasi);