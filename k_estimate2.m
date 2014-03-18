function [data_full,data_mv_baru]= k_estimate2(data_mentah,data,random_number_record,data_mv,kluster,k,nomor_mv)
	% INITIALIZATION PART
	[myu,covmat,pk,C] = maximizationStep(data,kluster,k);
	[data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv,nomor_mv);

	l_data_mv = size(data_mv_baru);
	data_full = double(data_mentah);

	for i=1:l_data_mv(1,1)
		data_full(random_number_record(i),nomor_mv(i)) = data_mv_baru(i,nomor_mv(i));
	end
	
	%---------------------------------------------------------
	% ITERATION PART
	
	status = 0;
	while(status~=1)
		temp_datamv = data_mv_baru;
		[kluster] = kmeans(k,data_full);
		[myu,covmat,pk,C] = maximizationStep(data_full,kluster,k);
		[data_mv_baru] = EM_estimate(myu,covmat,pk,k,data_mv_baru,nomor_mv);
		for i=1:l_data_mv
			data_full(random_number_record(i),:) = data_mv_baru(i,:);
		end
		if (isequal(temp_datamv,data_mv_baru)==1)
			status = 1;
		else
			status = 0;
		end
	end

end