%Probability Density Function of Multivariate Normal Distribution
function [f] = pdf_estimate(data,myu,covmat,k)
	pembilang = exp((-1/2)*(data-transpose(myu))*inv(covmat)*(transpose(data)-myu));
	penyebut = sqrt((2*3.14)^k*det(covmat));
	f = pembilang/penyebut;
end
