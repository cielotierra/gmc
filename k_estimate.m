function [data_full,data_mv_baru,covmat,myu]= k_estimate(data_mentah,data,random_number_record,data_mv,kluster,k,nomor_mv)
	% INITIALIZATION PART
	[myu,covmat,pk,C] = maximizationStep(data,kluster,k);
	[data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv);

	l_data_mv = size(data_mv_baru);
	data_full = double(data_mentah);
	
	for i=1:l_data_mv(1,1)
		a = random_number_record(i);
		b = nomor_mv(i);
		data_full(a,b) = data_mv_baru(i,b);
	end
	
	%---------------------------------------------------------
	% ITERATION PART

	status = 0;
	jumlah_iterasi = 0;

	while and((status~=1),(jumlah_iterasi~=5))
		%displaying number of iteration
		disp('Iterasi Ke-');
		jumlah_iterasi=jumlah_iterasi+1;
		disp(jumlah_iterasi);

		%Copying missing data to temporary (to be compared at the end)
		temp_datamv = data_mv_baru;

		%Copying new data missing to data full version
		for i=1:l_data_mv(1,1)
			a = random_number_record(i);
			b = nomor_mv(i);
			data_full(a,b) = data_mv_baru(i,b);
		end

		%KMEANS PART
		disp('KMEANS Proses');
		[kluster] = kmeans(k,data_full);
		disp('KMEANS Success');

		%Go to Maximazation Step
		[myu,covmat,pk,C] = maximizationStep(data_full,kluster,k);

		%EM Estimate Part
		[data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv_baru,nomor_mv);

		for i=1:l_data_mv
			data_full(random_number_record(i),:) = data_mv_baru(i,:);
		end
		
		status = isequal(data_mv_baru,temp_datamv);
	end
end