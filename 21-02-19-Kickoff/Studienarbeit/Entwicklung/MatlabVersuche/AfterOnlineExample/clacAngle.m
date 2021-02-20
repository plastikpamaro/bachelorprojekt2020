function [tau, cc] = clacAngle(sig, refsig, fs, max_tau, interp)
    n = length(sig)+length(refsig);
    
    SIG = fft(sig,n);
    REFSIG = fft(refsig,n);
    R = real(SIG .* conj(REFSIG));
    
    cc = ifft(R/abs(R), (interp*n));
    
    max_shift = floor(interp*n/2);
    if max_tau == 1
        max_shift = min(floor(interp*fs*max_tau),max_shift);
    end
    
    cc = cat(2,cc(-max_shift:end),cc(1:max_shift+1));
    
    test, shift = max(abs(cc));
    shift = shift - max_shift;
    
    tau = shift/(interp*fs);

end

