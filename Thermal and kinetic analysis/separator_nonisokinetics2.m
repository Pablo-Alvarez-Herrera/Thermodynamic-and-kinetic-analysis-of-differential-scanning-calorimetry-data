function [t_1stheat,T_1stheat,Q_1stheat,t_1stcool,T_1stcool,Q_1stcool,t_2ndheat,T_2ndheat,Q_2ndheat] = separator_nonisokinetics2(t,T,Q,m)

% defining 1st heat curve from begining of data until 199°C 
i_heat1_end=index_noniso_increase(T,199);

T_1stheat=T(1:i_heat1_end);Q_1stheat=Q(1:i_heat1_end)/m; t_1stheat=t(1:i_heat1_end);

% erasing 1stheat curve from data
T(1:i_heat1_end)=[]; Q(1:i_heat1_end)=[]; t(1:i_heat1_end)=[]; 

i_cool_in=index_noniso(T,199);

% erasing data before 199°C to start data for 1st cooling
T(1:i_cool_in)=[]; Q(1:i_cool_in)=[]; t(1:i_cool_in)=[];

% defining end of the 1st cooling at 21°C
T1stcooling_end=21;
i_cool_off=index_noniso(T,T1stcooling_end);

T_1stcool=T(1:i_cool_off); Q_1stcool=Q(1:i_cool_off)/m ;t_1stcool=t(1:i_cool_off);

% erasing 1stcool curve from data
T(1:i_cool_off)=[]; Q(1:i_cool_off)=[]; t(1:i_cool_off)=[];

% Defining start of 2nd heating at 25°C
T2ndheating_start=25;
i_heat2_in=index_noniso_increase(T,T2ndheating_start);
T(1:i_heat2_in)=[]; Q(1:i_heat2_in)=[]; t(1:i_heat2_in)=[];

T_2ndheat=T; Q_2ndheat=Q/m; t_2ndheat=t;


