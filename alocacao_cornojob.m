%% Start

clear; close all; clc;

%%% Deixa os eixos em LaTeX
set(groot, 'defaultTextInterpreter','latex');

%% Calculando num e den ITAE

syms s KP KD KI;

KPID_num = (KD*s^2+KP*s+KI);
KPID_den = s;

FT_num = 7.281*s^5 + 0.01002*s^4 + 238.1*s^3 + 0.1695*s^2;
FT_den = s^6 + 0.001017*s^5 + 68.78*s^4 + 0.05918*s^3 + 1168*s^2 + 0.8315*s;

Numerador = FT_num * KPID_num;
expand(Numerador);
collect(Numerador)

F_den = FT_den * KPID_den;
expand(F_den);
Denominador = F_den + Numerador;
expand(Denominador);
collect(Denominador)

EqCarac = s^2*(s+1)*(s+19.5)*(s+21.5)*(s+23.5)*(s+2);
expand(EqCarac)