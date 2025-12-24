function [T_base,Q_base,Qc] = nonisocurve_correction(T,Q,Tpeak_on,Tpeak_off)

% Obteniendo indices de inicio y final de peak 
i_on=index_noniso(T,Tpeak_on);
i_off=index_noniso(T,Tpeak_off);

% Quitandole peak a señal
T_baseline=T; Q_baseline=Q;
T_baseline(i_on:i_off)=[]; Q_baseline(i_on:i_off)=[];

% Creando vector de relleno de base de peak (temperaturas)
T_fill=linspace(T(i_on),T(i_off),(length(T)-length(T_baseline))+2);
T_fill=T_fill';
ultimo=length(T_fill);
T_fill(1)=[]; T_fill(ultimo-1)=[];

% Creando vector de relleno de base de peak (heat flow)
Q_fill=zeros(length(T_fill),1);
for i=1:length(Q_fill)
   Q_fill(i)=(Q(i_on)-((Q(i_off)-Q(i_on))/(T(i_off)-T(i_on)))*T(i_on))+((Q(i_off)-Q(i_on))/(T(i_off)-T(i_on)))*T_fill(i); 
end 

% Creando vectores baseline por partes
T_base=zeros(length(T),1);
Q_base=zeros(length(Q),1);

for i=1:(i_on-1)
T_base(i,1)=T(i,1);
Q_base(i,1)=Q(i,1);
end

for i=1:length(T_fill)
    T_base(i+i_on-1)=T_fill(i);
    Q_base(i+i_on-1)=Q_fill(i);
end 

for i=i_on:length(T_baseline)
    T_base(i+length(T_fill),1)=T_baseline(i);
    Q_base(i+length(Q_fill),1)=Q_baseline(i);
end

Qc=Q-Q_base;
end

