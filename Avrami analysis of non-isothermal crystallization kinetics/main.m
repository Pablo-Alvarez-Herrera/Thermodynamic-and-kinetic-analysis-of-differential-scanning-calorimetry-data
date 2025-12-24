%% Non-Isothermal Avrami Kinetics Analysis
% Analysis of crystallization kinetics under non-isothermal
% conditions at five different cooling rates.
%
% The script:
%   - Determines the Avrami exponent (n) and rate constant (k)
%     for each cooling rate
%   - Evaluates the crystallization completion (halt) time
%   - Generates Avrami plots and compares experimental and
%     model-predicted conversion as a function of temperature
%
% User input:
%   - Conversion vs. temperature data for five cooling rates
%%
%Reading Data from excel file: Crystallinity(-) as a function of
%Temperature(°C)
T50=xlsread('Data_example.xlsx','Sheet1','A:A');
X50=xlsread('Data_example.xlsx','Sheet1','B:B');
T100=xlsread('Data_example.xlsx','Sheet1','C:C');
X100=xlsread('Data_example.xlsx','Sheet1','D:D');
T150=xlsread('Data_example.xlsx','Sheet1','E:E');
X150=xlsread('Data_example.xlsx','Sheet1','F:F');
T200=xlsread('Data_example.xlsx','Sheet1','G:G');
X200=xlsread('Data_example.xlsx','Sheet1','H:H');
T250=xlsread('Data_example.xlsx','Sheet1','I:I');
X250=xlsread('Data_example.xlsx','Sheet1','J:J');

% Defining cooling rates
betas=[0.5 1.0 1.5 2.0 2.5];

% Creating matrix with results
results=zeros(length(betas),7);
results(:,1)=betas;
% Transforming X-axis from Temperature to time
t50=zeros(length(T50),1);
t100=zeros(length(T100),1);
t150=zeros(length(T150),1);
t200=zeros(length(T200),1);
t250=zeros(length(T250),1);

for i=1:length(T50)
    t50(i)=(T50(1)-T50(i))/betas(1);
end

for i=1:length(T100)
    t100(i)=(T100(1)-T100(i))/betas(2);
end

for i=1:length(T150)
    t150(i)=(T150(1)-T150(i))/betas(3);
end

for i=1:length(T200)
    t200(i)=(T200(1)-T200(i))/betas(4);
end

for i=1:length(T250)
    t250(i)=(T250(1)-T250(i))/betas(5);
end

% Defining limits of the Avrami analisis 
x_in=0.05; x_off=0.95;

% Taking times and conversion over the limits defined above 

X50_Avrami=X50(index_conversion(X50,x_in):index_conversion(X50,x_off));
t50_Avrami=t50(index_conversion(X50,x_in):index_conversion(X50,x_off));
X100_Avrami=X100(index_conversion(X100,x_in):index_conversion(X100,x_off));
t100_Avrami=t100(index_conversion(X100,x_in):index_conversion(X100,x_off));
X150_Avrami=X150(index_conversion(X150,x_in):index_conversion(X150,x_off));
t150_Avrami=t150(index_conversion(X150,x_in):index_conversion(X150,x_off));
X200_Avrami=X200(index_conversion(X200,x_in):index_conversion(X200,x_off));
t200_Avrami=t200(index_conversion(X200,x_in):index_conversion(X200,x_off));
X250_Avrami=X250(index_conversion(X250,x_in):index_conversion(X250,x_off));
t250_Avrami=t250(index_conversion(X250,x_in):index_conversion(X250,x_off));

% Calculating X-axis and Y-axis of Avrami plot
t50_Avrami_plot=log10(t50_Avrami);
X50_Avrami_plot=log10(-log(1-X50_Avrami));
t100_Avrami_plot=log10(t100_Avrami);
X100_Avrami_plot=log10(-log(1-X100_Avrami));
t150_Avrami_plot=log10(t150_Avrami);
X150_Avrami_plot=log10(-log(1-X150_Avrami));
t200_Avrami_plot=log10(t200_Avrami);
X200_Avrami_plot=log10(-log(1-X200_Avrami));
t250_Avrami_plot=log10(t250_Avrami);
X250_Avrami_plot=log10(-log(1-X250_Avrami));

% Calculating Avrami exponent and kinetic constant 

p50=polyfit(t50_Avrami_plot,X50_Avrami_plot,1);
r50=corrcoef(t50_Avrami_plot,X50_Avrami_plot);
results(1,2)=p50(1); results(1,7)=r50(2,1);

p100=polyfit(t100_Avrami_plot,X100_Avrami_plot,1);
r100=corrcoef(t100_Avrami_plot,X100_Avrami_plot);
results(2,2)=p100(1); results(2,7)=r100(2,1);

p150=polyfit(t150_Avrami_plot,X150_Avrami_plot,1);
r150=corrcoef(t150_Avrami_plot,X150_Avrami_plot);
results(3,2)=p150(1); results(3,7)=r150(2,1);

p200=polyfit(t200_Avrami_plot,X200_Avrami_plot,1);
r200=corrcoef(t200_Avrami_plot,X200_Avrami_plot);
results(4,2)=p200(1); results(4,7)=r200(2,1);

p250=polyfit(t250_Avrami_plot,X250_Avrami_plot,1);
r250=corrcoef(t250_Avrami_plot,X250_Avrami_plot);
results(5,2)=p250(1); results(5,7)=r250(2,1);

% Defining avrami exponents "n" and kinetics constants
n50=p50(1); K50=exp(p50(2)*log(10));
n100=p100(1); K100=exp(p100(2)*log(10));
n150=p150(1); K150=exp(p150(2)*log(10));
n200=p200(1); K200=exp(p200(2)*log(10));
n250=p250(1); K250=exp(p250(2)*log(10));

results(1,3)=K50*10000; 
results(2,3)=K100*10000;
results(3,3)=K150*10000; 
results(4,3)=K200*10000; 
results(5,3)=K250*10000;

% Calculating corrected kinetic constant 
K50_c=(K50)^(1/n50);
K100_c=(K100)^(1/n100); 
K150_c=(K150)^(1/n150); 
K200_c=(K200)^(1/n200); 
K250_c=(K250)^(1/n250);
% Saving results in results matrix
results(1,4)=K50_c;
results(2,4)=K100_c; 
results(3,4)=K150_c; 
results(4,4)=K200_c; 
results(5,4)=K250_c;

% Calculation of halt time by data and Avrami model 
th_50=(t50(index_conversion(X50,0.5))+t50(index_conversion(X50,0.5)-1))/2; results(1,5)=th_50; results(1,6)=((-log(0.5))/(K50))^(1/n50);
th_100=(t100(index_conversion(X100,0.5))+t100(index_conversion(X100,0.5)-1))/2; results(2,5)=th_100; results(2,6)=((-log(0.5))/(K100))^(1/n100);
th_150=(t150(index_conversion(X150,0.5))+t150(index_conversion(X150,0.5)-1))/2; results(3,5)=th_150; results(3,6)=((-log(0.5))/(K150))^(1/n150);
th_200=(t200(index_conversion(X200,0.5))+t200(index_conversion(X200,0.5)-1))/2; results(4,5)=th_200; results(4,6)=((-log(0.5))/(K200))^(1/n200);
th_250=(t250(index_conversion(X250,0.5))+t250(index_conversion(X250,0.5)-1))/2; results(5,5)=th_250; results(5,6)=((-log(0.5))/(K250))^(1/n250);

delta=0.05;
[t50_delta,X50_delta,X50_Avrami]=Avrami_model(t50,X50,n50,K50,delta);
[t100_delta,X100_delta,X100_Avrami]=Avrami_model(t100,X100,n100,K100,delta);
[t150_delta,X150_delta,X150_Avrami]=Avrami_model(t150,X150,n150,K150,delta);
[t200_delta,X200_delta,X200_Avrami]=Avrami_model(t200,X200,n200,K200,delta);
[t250_delta,X250_delta,X250_Avrami]=Avrami_model(t250,X250,n250,K250,delta);
 
% Reducing data in a fraction r to graph Avrami plot
r=0.05;
t50_Avrami_plot_r=reduction(t50_Avrami_plot,r);
X50_Avrami_plot_r=reduction(X50_Avrami_plot,r);
t100_Avrami_plot_r=reduction(t100_Avrami_plot,r);
X100_Avrami_plot_r=reduction(X100_Avrami_plot,r);
t150_Avrami_plot_r=reduction(t150_Avrami_plot,r);
X150_Avrami_plot_r=reduction(X150_Avrami_plot,r);
t200_Avrami_plot_r=reduction(t200_Avrami_plot,r);
X200_Avrami_plot_r=reduction(X200_Avrami_plot,r);
t250_Avrami_plot_r=reduction(t250_Avrami_plot,r);
X250_Avrami_plot_r=reduction(X250_Avrami_plot,r);

% Calculating model from reductin data 
X50_Avramimodel_plot=log10(K50)+n50*t50_Avrami_plot_r;
X100_Avramimodel_plot=log10(K100)+n100*t100_Avrami_plot_r;
X150_Avramimodel_plot=log10(K150)+n150*t150_Avrami_plot_r;
X200_Avramimodel_plot=log10(K200)+n200*t200_Avrami_plot_r;
X250_Avramimodel_plot=log10(K250)+n250*t250_Avrami_plot_r;

subplot(2,1,1);
plot(t50_delta,X50_delta,'ro',t50,X50_Avrami,'r',t100_delta,X100_delta,'bo',t100,X100_Avrami,'b',t150_delta,X150_delta,'go',t150,X150_Avrami,'g',t200_delta,X200_delta,'ko',t200,X200_Avrami,'k',t250_delta,X250_delta,'yo',t250,X250_Avrami,'y')
title('Experimental data vs model ')
xlabel('time(min)') 
ylabel('cristallinity')
legend('0.5 Kmin data','0.5 Kmin model','1.0 Kmin data','1.0 Kmin model','1.5 Kmin data','1.5 Kmin model','2.0 Kmin data','2.0 Kmin model','2.5 Kmin data','2.5 Kmin model')

subplot(2,1,2);
plot(t50_Avrami_plot_r,X50_Avrami_plot_r,'ro',t50_Avrami_plot_r,X50_Avramimodel_plot,'r',t100_Avrami_plot_r,X100_Avrami_plot_r,'bo',t100_Avrami_plot_r,X100_Avramimodel_plot,'b',t150_Avrami_plot_r,X150_Avrami_plot_r,'go',t150_Avrami_plot_r,X150_Avramimodel_plot,'g',t200_Avrami_plot_r,X200_Avrami_plot_r,'ko',t200_Avrami_plot_r,X200_Avramimodel_plot,'k',t250_Avrami_plot_r,X250_Avrami_plot_r,'yo',t250_Avrami_plot_r,X250_Avramimodel_plot,'y')
title('Avrami plot')
xlabel('log(t)') 
ylabel('log(-ln(1-X))')
legend('0.5 Kmin data','0.5 Kmin model','1.0 Kmin data','1.0 Kmin model','1.5 Kmin data','1.5 Kmin model','2.0 Kmin data','2.0 Kmin model','2.5 Kmin data','2.5 Kmin model')

display=sprintf('Avrami analysis between conversion %s and %d ',x_in,x_off);
disp(display)
disp('   b(K/min)  n(-)  K_c(min^-1) K*10^4(min^n) t0.5(min)   t0.5_Avrami(min) r_pearson')
disp(results)