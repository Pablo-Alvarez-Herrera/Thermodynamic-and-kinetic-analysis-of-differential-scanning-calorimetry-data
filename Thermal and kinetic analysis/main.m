%% DSC Data Analysis Script
% This script analyzes raw data from a standard DSC experiment:
%   - 1st heating scan: Thermal erasing
%   - Cooling scan: Crystallization
%   - 2nd heating scan: Melting
%
% The script performs the following tasks:
%   - Background correction of the crystallization exothermic peak
%   - Computation of the conversion as a function of temperature during crystallization
%   - Calculation of the enthalpy of crystallization
%
% User input required:
%   - Sample mass
%   - Temperature of the onset and offset of the crystallization peak
%%

% Reading raw data from excel file and state sample mass in DSC experiment
t=xlsread('Data_example.xlsx','Sheet1','A:A');
T=xlsread('Data_example.xlsx','Sheet1','B:B'); 
Q=xlsread('Data_example.xlsx','Sheet1','C:C');

% Define mass of the sample [mg]
m=5.00;

% Separating raw data and obtaining cooling curve (1stcool curve)
[t_1stheat,T_1stheat,Q_1stheat,t_1stcool,T_1stcool,Q_1stcool,t_2ndheat,T_2ndheat,Q_2ndheat]=separator_nonisokinetics2(t,T,Q,m);

% Defining the onset and offset of the crystalliation peak
Tpeak_on=116.6;Tpeak_off=85.0;

% Correction of the curves
[T_base,Q_base,Qc]=nonisocurve_correction(T_1stcool,Q_1stcool,Tpeak_on,Tpeak_off);

% Calculating index of beginning and end of peak
i_on=index_noniso(T_1stcool,Tpeak_on);
i_off=index_noniso(T_1stcool,Tpeak_off);

% Corrected curves
Qc=abs(Qc);

% Calculating conversions
X=conversion(T_1stcool(i_on:i_off),Qc(i_on:i_off));

% Calculating enthalpies of crystalization
H=trapz((t_1stcool(i_on:i_off))*60,Qc(i_on:i_off));

% Showing results
disp('Enthalpy of crystallization')
disp(H)

subplot(2,2,1)
plot(T,Q)
title('Thermogram')
xlabel('Temperature(°C)')
ylabel('Heat Flow (mW)')

subplot(2,2,2)
plot(T_1stcool,Qc)
title('Corrected crystallization peak')
xlabel('Temperature(°C)')
ylabel('Heat Flow (W/g)')

t_1stcool_peak=t_1stcool(i_on:i_off); t_1stcool_peak=t_1stcool_peak-t_1stcool(i_on);

subplot(2,2,3)
plot(t_1stcool_peak,Qc(i_on:i_off))
title('Crystallization peak as a function of time')
xlabel('time(min)')
ylabel('Heat flow (W/g)')

subplot(2,2,4)
plot(T_1stcool(i_on:i_off),X)
title('Non-isothermal conversion ')
xlabel('Temperature(°C)')
ylabel('crystallinity(--)')