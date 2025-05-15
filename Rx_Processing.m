function [decBits, eqSym] = Rx_Processing(rxSig, CIR, chanInfo, ...
    modOrder, ofdmDemod)


% Retrieve OFDM parameters
fftLen = ofdmDemod.FFTLength;
cpLen = ofdmDemod.CyclicPrefixLength;
numGuardBandCarriers = ofdmDemod.NumGuardBandCarriers;
pilotCarrierIdx = ofdmDemod.PilotCarrierIndices;
numOFDMSymbols = ofdmDemod.NumSymbols;
dataCarrierIdx = setdiff( ...
    numGuardBandCarriers(1)+1:fftLen-numGuardBandCarriers(2), ...
    [pilotCarrierIdx; fftLen/2+1]);

% Perfect channel estimation
chanDelay = channelDelay(CIR, chanInfo.ChannelFilterCoefficients);
chanEst = ofdmChannelResponse(CIR, chanInfo.ChannelFilterCoefficients, ...
    fftLen, cpLen, dataCarrierIdx, chanDelay);

% Revert Tx power normalization
scalingFactor = sqrt(fftLen - sum(numGuardBandCarriers) - 1) / fftLen;
rxSig = scalingFactor * rxSig;

% OFDM demodulation
ofdmInfo = info(ofdmDemod);
rxSig = rxSig(chanDelay + (1:ofdmInfo.InputSize(1)), :);
rxOFDM = ofdmDemod(rxSig);

figure;
scatterplot(rxOFDM(:));
title('Constellation After OFDM Demodulation (Before Equalization)');
xlabel('In-Phase');
ylabel('Quadrature');
grid on;

% Equalization (ZF)
numTx = size(chanEst, 3);
eqSym = zeros(size(rxOFDM,1), numOFDMSymbols, numTx);
for i = 1:numOFDMSymbols
    eqSym(:,i,:) = ofdmEqualize(rxOFDM(:,i,:), ...
        squeeze(chanEst(:,i,:,:)), 'Algorithm', 'ZF');
end

figure;
scatterplot(eqSym(:));
title('Constellation After Equalization');
xlabel('In-Phase');
ylabel('Quadrature');
grid on;

% Hard QAM demodulation
demodOut = qamdemod(eqSym, modOrder, 'UnitAveragePower', true);
demodOut = demodOut(:);

figure;
histogram(demodOut, 0:modOrder-1);
title('Histogram of Demodulated QAM Symbols');
xlabel('Symbol Index'); ylabel('Count');

% Convert symbols to bits
bitsPerSymbol = log2(modOrder);
decBitsMatrix = de2bi(demodOut, bitsPerSymbol, 'left-msb');
decBits = reshape(decBitsMatrix.', [], 1);  % column vector

end






