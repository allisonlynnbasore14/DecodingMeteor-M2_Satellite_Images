function outputsignal = PLL(data)
% the function takes in data and frequency of reference signal

% these variables are tentative
f0 = 1E6;
phase_ref = 0;  % phase of the reference signal 
fVCO = 1.1E6;  % frequency of VCO
KVCO = 0.5E6;  % gain of VCO

fs = 100E6; % Sampling frequency 
NF = 1000; % number of samples in simulation
fc = 0.2E6;  % cut-off frequency of lpf
coeff_lpf = 100;  % filter coeff
wc = fc/(fs/2); % window for the low pass filter 

%% Low Pass Filter
% takes in the signal, low pass filter it and feed it to VCO
fil_coeff = fir1(coeff_lpf,wc); % low pass filter
Ts = 1/fs;  % sampling period
t = [0:Ts:(NF-1)*Ts];   % time vector (0, Ts, 2Ts, ... (NF-1)*Ts)

%% VCO
VCO = zeros(1, NF); % initialize VCO signal --> will be accumulated over time 
phi = zeros(1, NF); % initialize VCO angle --> will be accumulated over time
% input signal is data

for n = 2:NF
    t = (n-2) * Ts; % current time
    error_mult(n) = data(n)*VCO(n-1);
    
    for m = 1:length(fil_coeff)
        if n-m+1>=1
            error_array(m)=error_mult(n-m+1);
        else
            error_array(m)=0;
        end
    end
    error(n) = sum(error_array.*data);
    
    phi(n) = phi(n-1)+2*pi*error(n)*KVCO*Ts; %update the phase of the VCO
    VCO(n) = sin(2*pi*fVCO*t+phi(n)); %compute VCO signal
    
end

