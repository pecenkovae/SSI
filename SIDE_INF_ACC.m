function [x,v] = SIDE_INF_ACC(poc_poloha,krit_casova_svetlost,ind_t,hran_y,d_safe)

h = 0.1;
t_max = 100; %toto mam stejne jako v definici MAIN, pak to z toho nejak vyextrahuj
T = 0:h:t_max;
t=T(ind_t); %startovaci cas
casovy_vektor = 0:h:t_max-t;

%vzdalenost od krizovatky
s = hran_y-poc_poloha+d_safe;
%kazdy ridic tedy vyrazi jinou rychlosti, aby to stihl vcas
v = s/krit_casova_svetlost;
x = poc_poloha + casovy_vektor * v;

end