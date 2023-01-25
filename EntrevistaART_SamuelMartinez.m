clear all
clc
close all

% Problema Entrevista ART - Samuel Martinez

%% P.0. GENERADOR 1-5
n_puntos=100000;

p0=randi([1 5],1,n_puntos); % Pto. partida: se generan 1M números de 1 a 5 con distribución uniforme. 

% Distribución de probabilidad:
[GC GR] = groupcounts(p0');
figure
bar(GR,GC); % Se verifica convergencia a uniformidad en la distribución de probabilidad, hay un 1/5->20% de probabilidad que salga cada símbolo.
title('Distribución generador original [1-5]')

%% P.1. GENERADOR 1-7
% Se quiere extrapolar el problema, para contar con un generador de 1 a 7,
% garantizando distribución uniforme de 1/7 a partir del generador
% anterior: randi([1 5]).


%P.1.1. Para mantener la uniformidad, por simple multiplicidad, la primera idea ha sido:
for i=1:n_puntos
    p11(i)=mod(randi([1 5])+randi([1 5])+randi([1 5])+randi([1 5])+randi([1 5])+randi([1 5])+randi([1 5]),7)+1;
end

% Distribución de probabilidad:
[GC GR] = groupcounts(p11');
figure
bar(GR,GC); % Para cada número aleatorio de 1-7 se requiere llamar al generador original 7 veces para poder hacer la operación de modulo a 7, y mantener la uniformidad.
title('P.1.1. Generador [1-7] por multiplicidad')
 
%P.1.2. Buscando alternativas en la red, se propone otra que considero que
%es más ingeniosa y que requiere menos llamadas a la función randi([1 5])
%pero asumiendo la posibilidad de que haya casos en los caigamos en el estado de 
% darle al boton de generar otra vez, cuando sale el 0 -> P=4/25=16% de las veces.

M=[1,2,3,4,5; 6, 7, 1, 2, 3; 4, 5, 6, 7, 1; 2,3,4,5,6;7,0,0,0,0];
cont=0;
for i=1:n_puntos
    p12(i)=0;
    while (p12(i)==0)
        p12(i)=M(randi([1 5]),randi([1 5])); % Matriz 5x5: 2 llamadas a randi([1 5])
        cont=cont+1;
    end
end
repeticiones=cont/n_puntos; % Era de esperar, convergencia a 25/21

% Distribución de probabilidad:
[GC GR] = groupcounts(p11');
figure
bar(GR,GC); % La uniformidad se garantiza ya que la oferta de posibles valores de 1-7 es la misma en la matriz.
title('P.1.2. Generador [1-7] por matriz grupos de 5')
 

