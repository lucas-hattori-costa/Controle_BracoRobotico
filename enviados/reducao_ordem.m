%% Start

clear; close all; clc;

%%% Deixa os eixos em LaTeX
set(groot, 'defaultTextInterpreter','latex');

%% Definindo FT's

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

D = zeros(3);

ee = ss(A,B,C,D); % Espaco de Estados de malha aberta

fts = tf(ee); % Mudanca para FTs

FT_T2_theta2dot = fts(3,3); % FT relacionando thetadot2 x T2

%%% Consertando FT1

[num,den]=tfdata(FT_T2_theta2dot,'v');
num2 = [num 0];
den2 = [den 0];
FT_T2_theta2dot = tf(num2,den2);

%% Redução de Ordem

%%% Terceira ordem
[sysb,g] = balreal(FT_T2_theta2dot);
sysr3 = modred(sysb,[4 5 6],'del');
sysr3 = zpk(sysr3);
figure
bodeplot(FT_T2_theta2dot,sysr3,'r--')
title('Diagrama de Bode - sistema original e reduzido')
legend('Original','Reduzido para Ordem 3')
xlim([1 10])

%%% Quarta ordem
num_red = [7.281 0.004831 238.1 -1.32e-10];
den_red = [1 0.0003049 68.78 0.01021 1168];
figure
sysr4 = tf(num_red,den_red);
bodeplot(FT_T2_theta2dot,sysr4,'r--')
title('Diagrama de Bode - sistema original e reduzido')
legend('Original','Reduzido para Ordem 4')
xlim([1 10])