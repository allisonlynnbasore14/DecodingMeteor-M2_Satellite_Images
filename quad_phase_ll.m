% this function takes in data and signal parameters and returns the bits
% which can be translated into images

function bits = quad_phase_ll(data, samp_freq, samp_num, osci_freq)
% signal parameters
samp_period = 1/samp_freq;  % sampling period is inverse of samp_frequency
t_vec = [0:samp_period:(samp_num-1)*samp_period];   % time vector

% phase difference detetctor
% pdd detects the phase of two signals and returns the 
% phase difference

% divide the data into two different components imag and real
real_data = real(data);
imag_data = sign(imag(data)).*abs(imag(data));

% convert data into samples
samp_length = length(real_data)/samp_num;
sum_samp_real = 0;  % initialize the sum samp of real
sum_samp_imag = 0;  % initialize the sum samp of imag
sample_real = zeros(1,length(real_data));   % vector initialization
sample_imag = zeros(1,length(imag_data));   % vector initialization
for i = 1:length(real_data)
    if (mod(i,samp_length)~=0) 
        sum_samp_real = sum_samp_real + real_data(i);
        sum_samp_imag = sum_samp_imag + imag_data(i);
    else
        avg_real = sum_samp_real/samp_length;
        avg_imag = sum_samp_imag/samp_length;
        sample_real(count) = avg_real;
        sample_imag(count) = avg_imag;
        count = count + 1;
        sum_samp_real = 0;
        sum_samp_imag = 0;
    end
end
       
% window for fft
win = rectwin(length(t_vec));

for t = 2:length(t_vec-1)
    % current signal 
    present_sig_real = fft(sample_real(t).*win);
    present_sig_imag = fft(sample_imag(t).*win);
    
    % referencing past signal
    past_sig_real = fft(sample_real(t-1).*win);
    past_sig_imag = fft(sample_imag(t-1).*win);
    
    % calculate the difference
    % rq = (r[n]-r[n-1])*sample_rate/(2*pi*osci_freq)
    [~, idx_present]= max(abs(data(t)));
    [~, idx_past] = max(abs(data(t-1)));
    phasediff = angle(data(idx_past))-angle(data(idx_present));
end





end