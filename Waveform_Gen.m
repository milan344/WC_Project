function [txSig, srcBits] = Waveform_Gen(modOrder, ofdmMod)


% Random bit generation 
bitsPerSymbol = log2(modOrder);
ofdmInfo = info(ofdmMod);
numDataSubcarriers = ofdmInfo.DataInputSize(1);
numSymbols = ofdmInfo.DataInputSize(2);

numBits = bitsPerSymbol * numDataSubcarriers * numSymbols;
srcBits = randi([0 1], numBits, 1);

% QAM Modulation
encSym = qammod(srcBits, modOrder, ...
    'InputType', 'bit', 'UnitAveragePower', true);
figure;
scatterplot(encSym(:));
title('QAM Constellation After Modulation');
%  OFDM Modulation 
ofdmData = reshape(encSym, ofdmInfo.DataInputSize); % [subcarriers × symbols]
ofdmPilot = qammod(randi([0 3], ofdmInfo.PilotInputSize), 4, 'UnitAveragePower', true);
txSig = ofdmMod(ofdmData, ofdmPilot);



%  Normalize power
scalingFactor = ofdmMod.FFTLength / ...
    sqrt(ofdmMod.FFTLength - sum(ofdmMod.NumGuardBandCarriers) - 1);
txSig = scalingFactor * txSig;
figure;
plot(real(txSig));
xlabel('Sample Index');
ylabel('Amplitude');
title('Time-Domain OFDM Signal with Cyclic Prefix');
grid on;
end





