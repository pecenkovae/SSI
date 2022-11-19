close all
clear variables
clc

%%toto je skript jiz s pouzitim rozhodovaciho pravidla

%parametry GIGU na main... v protokolu pak uved, na jake krizovatce byl nameren,
%viz clanek TH+MK
main_alpha = 3;
main_beta = 0.1;
main_lambda = 2;

%pocet aut celkem (vcetne tech jiz za krizovatkou
L = 20;

%vysledek IDM modelu na hlavni komunikaci
[main_x_vsechna_vozidla,main_v_vsechna_vozidla] = MAIN(L,main_alpha,main_beta,main_lambda);
[n,m]= size(main_x_vsechna_vozidla);
%%
%zde vyjmu pouze vozidla, ktera jsou jeste za krizovatkou
main_x = main_x_vsechna_vozidla;
%%
for i = 1:m
    if main_x_vsechna_vozidla(1,i)>500
        main_x(:,1)=[];
    end
end

%N je pocet vozidel pred krizovatkou
[~,N] = size(main_x); 
%definice hranice krizovatky
hran_x = 500;
hran_y = 500;

%%
d_safe = 2;
%nejdelsi vzdalenost od krizovatky na vedlejsi komunikaci
M = 100;
%poc. poloha vozidel na vedlejsi komunikaci
s_side = hran_y - (2:d_safe:M);
%pocet aut, na vedlejší komunikaci v zásobníku
zasoba = length(s_side);



ind_t = 1;
j=1;%inicializace te matice

[side_x_all,k_all,ind_t] = ONE_CLEAR_INF_ACC(main_x,j,ind_t); %%%%%tady potrebuju nejak zapsat pocet odjetych vozidel!!!!!
%%
for j = 2:N %ted to chci udelat pro kazda j
    k_all(j-1);
    [side_x,k,ind_t] = ONE_CLEAR_INF_ACC(main_x,j,ind_t);
    side_x_all = [side_x_all side_x];
    k_all = [k_all k];
end

%%
T = 0:0.1:100;
[~,p] = size(side_x_all);
odjete_vozidlo = 1;
s_side = 496:-d_safe:498-2*(p-1);%pocatecni polohy pro prvni iteraci
ind_start = 1;
for i = 2:p
    if i == 2
        ind_max = find(side_x_all(:,i),1);
        posunuti = SIDE_t(T(1),T(ind_max+1),T(10),s_side);
        [a,~] = size(side_x_all(1:ind_max,i:p));
        [b,~] = size(posunuti);
        if a < b
            posunuti(end,:) = [];
        end
        side_x_all(1:ind_max,i:p) = posunuti;

    else
        ind_start = find(side_x_all(:,i)==0,1);
        ind_max = find(side_x_all(:,i)==498,1);
        posunuti = SIDE_t(T(ind_start),T(ind_max+1),T(ind_start + 5)-T(ind_start),side_x_all(ind_start-1,i:p));
        [a,~] = size(side_x_all(ind_start:ind_max,i:p));
        [b,~] = size(posunuti);
        if a < b
            posunuti(end,:) = [];
        end
        side_x_all(ind_start:ind_max,i:p) = posunuti;

    end
    odjete_vozidlo = odjete_vozidlo +1;
end


%% vykresleni vic z dalky
% 
figure('NumberTitle', 'off', 'Name', 'Vykresleni situace zdalky');
i = 1;
while i <= n
    p1 = plot(main_x_vsechna_vozidla(i,:),hran_y,'ob');
    hold on
    p2 = plot(hran_x,side_x_all(i,:),'or');
    xlim([300, 900]);
    ylim([450, 600]);
    pause(0.01);
    hold off
    i = i+1;
end


%% vykresleni z blizka
figure('NumberTitle', 'off', 'Name', 'Vykresleni situace vice zblizka');
i = 1;
while i <= n
    p1 = plot(main_x_vsechna_vozidla(i,:),hran_y,'ob');
    hold on
    p2 = plot(hran_x,side_x_all(i,:),'or');
    xlim([400, 600]);
    ylim([450, 550]);
    pause(0.01);
    hold off
    i = i+1;
end

