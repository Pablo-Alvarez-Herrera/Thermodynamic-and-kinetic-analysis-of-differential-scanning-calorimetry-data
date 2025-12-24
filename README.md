%% Non-Isothermal Avrami Kinetics Analysis

Analysis of crystallization kinetics under non-isothermal conditions at five different cooling rates.
The script:
- Determines the Avrami exponent (n) and rate constant (k) for each cooling rate
- Evaluates the crystallization completion (halt) time
- Generates Avrami plots and compares experimental and model-predicted conversion as a function of temperature

User input:
- Conversion vs. temperature data for five cooling rates

%% DSC Data Analysis Script

This script analyzes raw data from a standard DSC experiment:
- 1st heating scan: Thermal erasing
- Cooling scan: Crystallization
- 2nd heating scan: Melting

The script performs the following tasks:
- Background correction of the crystallization exothermic peak
- Computation of the conversion as a function of temperature during crystallization
- Calculation of the enthalpy of crystallization

User input required:
- Sample mass
- Temperature of the onset and offset of the crystallization peak
