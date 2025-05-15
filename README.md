# WC_Project
# SISO mmWave OFDM Link Simulation with Custom Horn Antennas

## Overview  
This repository provides an end‑to‑end MATLAB simulation of a point‑to‑point Single‑Input/Single‑Output (SISO) millimeter‑wave (mmWave) link in an urban canyon environment. It combines realistic ray‑traced channel modeling with a custom horn antenna pattern, 16‑QAM OFDM physical‑layer processing, and zero‑forcing equalization to evaluate BER and received power under various antenna directivity settings.

---

## Key Features

- **Geometry & Ray Tracing**  
  - Places Tx/Rx in a New York City street canyon using `txsite`/`rxsite`  
  - Ray tracing via `propagationModel("raytracing")` with up to reflections and optional atmospheric attenuation  
  - Wraps rays in a discrete‐time FIR channel via `comm.RayTracingChannel`  

- **Custom Directional Antennas**  
  - Single‑element “horn” designed with `phased.CustomAntennaElement`  
  - Configurable half‑power beamwidth (HPBW) and sidelobe attenuation (SLA)  
  - Manual steering by setting `tx.AntennaAngle` / `rx.AntennaAngle`  

- **OFDM Physical Layer**  
  - 64 data subcarriers + cyclic prefix (CP length = 16)  
  - 16‑QAM data symbols, pilot insertion, guard bands  
  - `comm.OFDMModulator` / `comm.OFDMDemodulator`  
  - Zero‑Forcing (ZF) equalization with perfect CSI  

- **Performance Metrics & Visualization**  
  - Received power estimation (dBm)  
  - BER calculation via `comm.ErrorRate`  
  - Scatter plots & histograms at each stage (modulation, pre‑ and post‑equalization)  

---

