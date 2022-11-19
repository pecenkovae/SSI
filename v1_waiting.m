function v_first = v1_waiting(t,t498,poc_poloha)
% INPUT:
%   t...cas
%   t498... cas, ve kterem to vozidlo musí být v tom 498
% OUTPUT:
%   v_first...rychlost prvniho vozidla cekajiciho v zasobniku

%pocatecni rychlost vozidla je nulova zejo
A = pi/(2*t498)*(498-poc_poloha);
B = pi/t498;
    v_first = A*sin(B*t);

end