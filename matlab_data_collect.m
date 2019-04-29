% findsdru
% probesdru
rx = comm.SDRuReceiver('Platform','B210','SerialNum','30CF996');
rx.Gain = 0.001;
rx.CenterFrequency = 137.9e6;
rx.DecimationFactor = 50;
rx.FrameLength = 5000;
rx_log = dsp.SignalSink;

for counter = 1:20
data = rx;
rx_log;
end
% Array for

% dlmwrite('data.csv', [], 'delimiter', ',');
% y = step(rx);
% dlmwrite('data.csv', y, 'delimiter', ',', '-append');
%  f1 = fopen('data2.dat', 'w');
 
 ytemp = zeros(2*rx.FrameLength, 1);
while 1
    y = step(rx);
    ytemp(1:2:end) = real(y);
    ytemp(2:2:end) = imag(y);
    fwrite(f1, ytemp, 'int16');
%     dlmwrite('data.csv', y, 'delimiter', ',', '-append');
end