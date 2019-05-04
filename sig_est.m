function estimate_sig= sig_est(data)
quadrapled = data.^4;
fft_quad = fft(quadrapled);

deltaF = max(fft_quad);
theta = angle(deltaF)/4;

estimate_sig = data*exp(-1i*(deltaF+theta));
end