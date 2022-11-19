function [side_x,k, ind_za] = ONE_CLEAR_INF_ACC(main_x,j,ind_t)
%definice hranice krizovatky
hran_x = 500;
hran_y = 500;

side_alpha = 1.2;
side_beta = 2;
side_lambda = 1;

d_safe = 2;

h = 0.1;
t_max = 100; %toto mam stejne jako v definici MAIN, pak to z toho nejak vyextrahuj
T = 0:h:t_max;
t=T(ind_t); %startovaci cas
n = length(T);

%nejdelsi vzdalenost od krizovatky
M = 100;
%poc. poloha a rychlost vozidel na vedlejsi komunikaci
s_side = hran_y - (2:d_safe:M);
%pocet aut, na vedlejší komunikaci v zásobníku
zasoba = length(s_side);
side_x = zeros(n,20); %pro jistotu ji udelam hodne velkou

%%
t_V = 0;
k = -1; %while probehne aspon jednou za techto podminek

t_H = (find(main_x(:,j)>hran_x,1)-ind_t)*h;
while t_V < t_H
    k = k+1;

    if k > 0
        [x,~] = SIDE_INF_ACC(s_side(1),Y,ind_t,hran_y,d_safe);
        side_x(1:length(x),k) = x;

        t_imaginar = t + Y; %toto je posun v case. ted potrebuji najit nejpodobnejsi hodnotu ve vektoru T a urcit jeji index
        [~,idx]= min(abs(T-t_imaginar)); %%%% pozor, budu muset hodne pocitat s tim val pri pozorvavani svetlosti dalsiho vozidla
        ind_t = idx;
        t = T(ind_t);
    end
    %Y jsou generovane kriticke svetlosti ridicu na vedlejsi komunikaci
    Y = gigrnd(side_alpha+1,2*side_lambda,2*side_beta);
    krit_t(k+1) = Y;
    t_V = t_V + Y;
end

[~,num_car] = size(side_x);
for i = 1:num_car
    side_x(:,i) = circshift(side_x(:,i),sum(side_x(:,i)==0));
end


%%

ind_pred = find(main_x(:,j)>500-d_safe,1)-1;

%%
for i = num_car:-1:1

    if side_x(ind_pred,i)==0
        side_x(:,i) = []; %odstraneni prazdnych sloupcu
    end

end
[~,k] = size(side_x);
%%
ind_za = find(main_x(:,j)>500+d_safe,1);
end