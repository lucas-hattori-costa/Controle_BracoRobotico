%% De sempre

%%% Deixa os eixos em LaTeX
set(groot, 'defaultLegendInterpreter','latex');

%% Definindo a FT estudada

clear; close all; clc;
%%% Parametros
m = 2;
Mbase = 6;
L = 0.5;
c = 8.5e-5;
b = 7.12e-3;
g = 9.81;

%%% Espaco de estados

M = [1, 0, 0, 0, 0, 0; 0, (2*m+Mbase)*L, 0, 3*m*(L^2)/2, 0, m*(L^2)/2; 0, 0, 1, 0, 0, 0; 0, 2*m*L, 0, 3*m*(L^2)/2, 0, 2*m*(L^2)/3; 0, 0, 0, 0, 1, 0; 0, m*L/2, 0, m*(L^2)/6, 0, m*(L^2)/3];

I = eye(6);

Minv = I/M;

Atil = [0, 1, 0, 0, 0, 0; 0, -b*L, 0, 0, 0, 0; 0, 0, 0, 1, 0, 0; 0, 0, -3*m*L*g/2, -c, -m*L*g/2, 0; 0, 0, 0, 0, 0, 1; 0, 0, 0, c, -m*L*g/2, c];

Btil = [0, 0, 0; L, 0, 0; 0, 0, 0; 0, 1, 0; 0, 0, 0; 0, 0, 1];

A = Minv*Atil;

B = Minv*Btil;

C = [1, 0, 0, 0, 0, 0; 0, 0, 0, 1, 0, 0; 0, 0, 0, 0, 0, 1];

D = zeros(3,3);

ee = ss(A,B,C,D); % Espaço de Estados de malha aberta

fts = tf(ee); % Mudança para FTs

FT_T2_theta2dot = fts(3,3); % FT relacionando thetadot2 x T2

%%% Consertando FT1

[num,den]=tfdata(FT_T2_theta2dot,'v');
num2 = [num 0];
den2 = [den 0];
FT_T2_theta2dot = tf(num2,den2);

%% Step Zaigler Naicous

figure
step(FT_T2_theta2dot)

%% Rlocus Zaigler Naicous

figure
rlocus(feedback(FT_T2_theta2dot, 1))

%% Pegando FT de T2 por theta2

FT_T2_theta2 = fts(5,3); % FT relacionando theta2 x T2

%%% Consertando FT2

[num,den]=tfdata(FT_T2_theta2 ,'v');
num2 = [num 0];
den2 = [den 0];
FT_T2_theta2  = tf(num2,den2);