function [data_full,data_mv_baru,covmat]= k_estimate2(data_mentah,data,random_number_record,data_mv,kluster,k,nomor_mv)
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
	%{
	status = 0;
	jumlah_iterasi = 0;
	while status==0
		disp ('iterasi');
		jumlah_iterasi=jumlah_iterasi+1;
		disp(jumlah_iterasi);
		temp_datamv = double(data_mv_baru);
		[kluster] = kmeans(k,data_full);
		[myu,covmat,pk,C] = maximizationStep(data_full,kluster,k);
		b = size(covmat);
		disp(b);
		%a = max(covmat);
		%disp(a);
		[data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv_baru,nomor_mv);
		
		for i=1:l_data_mv
			data_full(random_number_record(i),:) = data_mv_baru(i,:);
		end
		
		if (temp_datamv==data_mv_baru)
			status = 1;
		else
			status = 0;
		end
	end
	%}

	status = 0;
	jumlah_iterasi = 0;
	while status==0	
		try
			disp ('iterasi');
			jumlah_iterasi=jumlah_iterasi+1;
			disp(jumlah_iterasi);
			temp_datamv = double(data_mv_baru);
			[kluster] = kmeans(k,data_full);
			[myu,covmat,pk,C] = maximizationStep(data_full,kluster,k);
		catch exceptionNaN
			if(exceptionNaN.identifier,'')
	end
end