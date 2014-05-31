function [rmse] = rmse_estimate(y_guess,y_ans)
	%y_guess = nilai hasil estimasi/imputasi
	%y_ans = nilai sebenarnya

	l_data = size(y_guess);
	temp = 0;

	for i=1:l_data(1,1)
		temp = temp + ((y_guess(i,1)-y_ans(i,1))^2);
	end

	pembilang = sqrt(temp);
	rmse = pembilang/l_data(1,1);
end