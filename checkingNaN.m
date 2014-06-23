function [hasil] = checkingNaN(data)
	cek = isnan(data);
	l = size(cek);
	hasil = 0;
	for i=1:l(1,1)
		for j=1:l(1,2)
			if(cek(i,j)==1)
				hasil = 1;
				break;
			end
		end
		if(hasil==1)
			break;
		end
	end
end