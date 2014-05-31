function [y_guess,y_ans] = data_filter(data_mv,data_mv_baru,data_mv_asli)
	l_data = size(data_mv);
	ix = 0;
	for i=1:l_data(1,1)
		for j=1:l_data(1,2)
			if (isnan(data_mv(i,j))==1)
				ix = ix+1;
				y_guess(ix,1)=data_mv_baru(i,j);
				y_ans(ix,1)=data_mv_asli(i,j);
			end
		end
	end
end