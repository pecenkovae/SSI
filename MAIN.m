function [Hx,Hv] = MAIN(N, alpha, beta, lambda)
%INPUT: N...pocet aut, na hlavni komunikaci, ktere budu sledovat,
%       alpha, beta, lambda....parametry GIGU na main... v protokolu pak uved, na jake krizovatce byl nameren,
%       viz clanek TH+MK


global h                           % krok
global a b v0 d_safe T_safe delta  % pro definici IDM 

t = 0;                              % startovni cas
tmax = 100; xmax = 2000;              % nastaveni mezi

%casovy krok
h = 0.1;


model = 'IDM';
%parametry IDM modelu na hlavní komunikaci
v0 = 120 / 3.6; %km/h %kýžená rychlost....velka silnice z Vysokeho Myta do Pce
T_safe = 2; %s bezpečný časový odstup
d_safe = 4; %m bezpečná vzdálenost
a = 0.8; %m/s^2 optimální zrychlení
b = 0.4; %m/s^2 optimální brždění ..... ridici by nemeli skoro vubec brzdit
delta = 4; %mocnicna, toto zkus měnit

global v_poc A B
v_poc = normrnd(50,10)/3.6; %m/s
A = 5; 
B = 0.2;

%hranice krizovatky bude v (x,y) = (500,500) a budeme sledovat 500 metru
%pred a za krizovatkou
hran_x = 500;
hran_y = 500;

%prislusny pocet svetlosti mezi auty na hlavni komunikaci
t_main = zeros(1,N);
%za jak dlouho se auto dostane ke hranici krizovatky.... zde nakonec generuj z generátoru, který jsem si sama napsala!
for i=1:N
    t_main(i) = gigrnd(alpha+1,2*lambda,2*beta); %pozor, toto je v sekundach, jsou to casove svetlosti
end
%poc. rychlosti pozorovanych vozidel
v_main = normrnd(50,0,[1,N])/3.6;
%vzdalenost vozidla v metrech od sebe
s_main = v_main .* t_main;
%vzdalenost vozidel od hranice krizovatky(tedy poc. poloha vsech pozidel)
s_hr_main = 0*s_main;
for i=1:N
    s_hr_main(N+1-i)=sum(s_main(1:i));
end
s_hr_main
%% vykresleni hlavni komunikace
%   Hx...polohy v zavislosti na case vsech vozidel
%   Hv...rychlosti v zavislosti na case vsech vozidel
Hx = [];
Hv = [];
%   x...polohy v 1 čase všech vozidel
%   v...rychlosti v 1 čase všech vozidel
x = s_hr_main;
v = v_main;
first_ini = x(1);

model = 'IDM';
road = 'side';
while t <= tmax
    for j = 1:N
        if j == 1
            x(j) = x1(t,v(1), first_ini,road);
            v(j) = v1(t,v(1),road);
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