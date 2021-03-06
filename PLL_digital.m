function bits = PLL_digital(data)
% input is the complex number of 
% divide the data into set of samples
samp_num = 10000;   % integer
set_num = round(length(data)/samp_num); % integer
sig_estimated = zeros(set_num,samp_num); % vector row: set_num / column: samp_num 
for i = 1:setnum
    sig_sampled = data(samp_num*(i-1)+1:samp_num);
    sig_estimated(i) = sig_est(sig_sampled);
end
    
% convert the set signal into one set
reshape(sig_estimated, [1,length(data)]);

% initialize the final bits vector
bits = zeros(1,length(data)*2); % multiply the length of data by 2 because each datatip has two bits of info

for i = 1:length(bits)
    if (mod(i,2) ~= 0)
        if (floor(real(sig_estimated(i)))==1)
            if (floor(imag(sig_estimated(i)))==1)
                bits(i) = 1;
                bits(i+1) = 1;
            elseif (floor(imag(sig_estimated(i)))==-1)
                bits(i) = 1;
                bits(i+1) = 0;
            end
        elseif (floor(real(sig_estimated(i)))==-1)
            if (floor(imag(sig_estimated(i)))==1)
                bits(i) = 0;
                bits(i+1) = 1;
            elseif (floor(imag(sig_estimated(i)))==-1)
                bits(i) = 0;
                bits(i+1) = 0;
            end
        end
    end
end
    

end