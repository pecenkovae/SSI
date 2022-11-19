function x_first = x1_waiting(t,t498,poc_poloha)
% INPUT:
%   t...cas
%   t498... cas, ve kterem to vozidlo musí být v tom 498
%  poc_poloha
% OUTPUT:
%   x_first...poloha prvniho vozidla cekajiciho v zasobniku

%pocatecni rychlost vozidla je nulova zejo

A = pi/(2*t498)*(498-poc_poloha);
B = pi/t498;
if t < t498
    x_first = -A/B*cos(B*t)+poc_poloha+A/B;
elseif t >= t498
    x_first = 498;
end
