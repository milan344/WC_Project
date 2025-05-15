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

---

## Figures

### 1. Initial Site View  
![Initial Site View](/docs/images/initial site view.png)  
OpenStreetMap 3D view centered on Bryant Park and the Manhattan canyon.

---

### 2. All Possible Ray Paths (No Weather)  
![All Possible Paths](/docs/images/all possible path.png)  
Deterministic ray‑tracing with up to 10 reflections, perfect‐reflector materials.

---

### 3. All Possible Ray Paths (With Gas + Rain)  
![After Including Weather](/docs/images/after including weather .png)  
Same as above, but with ITU‑R rain/gas attenuation added to the propagation model.

---

### 4. Directivity Toward Receiver (Tx Horn)  
![Increasing Directivity Towards Receiver](/docs/images/increasing directivity towards reciver.png)  
Custom horn pattern steered manually at the primary reflection path.

---

### 5. LOS Path Only  
![LOS Path](/docs/images/los_path.png)  
Line‑of‑sight path in green overlaid on the site viewer.

---

### 6. Tx/Rx Positions  
![Tx & Rx Positions](/docs/images/tx_rx_position.png)  
Markers show transmitter on tower roof and receiver at street‐level.

---

### 7. Rays After Steering  
![Rays After Steering](/docs/images/rays after sterring.png)  
Ray‑trace result when horn is pointed along the strongest departure angle.
