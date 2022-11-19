function Hx = SIDE_t(tstart,tmax_main,t498,s_side)
%INPUT: M... nejvetsi vzdalenost od hranice krizovatky, kterou budu
%       pouzivat
%       tstart... startovaci cas
%       tmax_main ... delka experimentu na hlavni komunikaci
global h                           % krok
global a b v0 d_safe T_safe delta  % pro definici IDM

%casovy krok
h = 0.1;

%parametry IDM modelu na vedlejší komunikaci
v0 = 70 / 3.6; %km/h %kýžená rychlost
T_safe = 2; %s bezpečný časový odstup
d_safe = 2; %m bezpečná vzdálenost
a = 3; %m/s^2 optimální zrychlení
b = 3; %m/s^2 optimální brždění
delta = 4; %mocnicna


model = 'IDM';

t = 0;                              % startovni cas
tmax_side = tmax_main-tstart; xmax = 2000;              % nastaveni mezi


%hranice krizovatky 
hran_x = 500;
hran_y = 500;


%poc. poloha a rychlost vozidel na vedlejsi komunikaci
%s_side = hran_y - (4:d_safe:M); %je zde i to imaginarni vozidlo, ktere funguje jako stopka
v_side = zeros(1,length(s_side));
%pocet aut, na vedlejší komunikaci v zásobníku
N = length(s_side);


%%
%   Hx...polohy v zavislosti na case vsech vozidel
%   Hv...rychlosti v zavislosti na case vsech vozidel
Hx = [];
Hv = [];
%   x...polohy v 1 čase všech vozidel
%   v...rychlosti v 1 čase všech vozidel
x = s_side;
v = v_side;
first_ini = x(1)
%Hx = [Hx; x];
%Hv = [Hv; v];
model = 'IDM';

while t <= tmax_side
    for j = 1:N
        if j == 1
            x(j) = x1_waiting(t,t498, first_ini);
            v(j) = v1_waiting(t,t498, first_ini);
            
        else
            x(j) = x(j) + h * v(j);
            v(j) = v(j) + h * v_tecka(x,v,model,j); 
        end
    end
    Hx = [Hx; x];
    Hv = [Hv; v];
    t = t + h;
end
end