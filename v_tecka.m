function [dv] = v_tecka(x,v,model,j)
% tato funkce predstavuje jednotlive modely, ktere jsme si ukazali na
% prednasce, to v s teckou = .. toto je pouze pro skript
% gen_s_poc_podminkou!!!! 
global a b  d_safe T_safe delta gamma v_max v0
switch model
    case 'CFM'%car following model
        dv = (v(j-1) - v(j))/ T_safe;
    case 'OVM'

        if j == 1
            d = Inf;
        else
            d = x(j-1) - x(j);
        end
        v_opt = 0.5 * v_max(j) * (tanh(d-d_safe)+1); %d-d_safe... cim mam vic mista, tim rychleji muzu jet, +1 tam rika, ze auta nemohou couvat, protoze to nebude vychazet zapozne
        dv = gamma * (v_opt - v(j));

    case 'IDM'
        if j == 1
            d_star = 0;
            mezera = Inf;
        else
            mezera = x(j-1) - x(j);
            d_star = max([0,d_safe + v(j)*T_safe - (v(j) * (v(j-1)-v(j))) / (2 * sqrt(a * b))]); %kýžený odstup
        end

        dv = a * (1-(v(j)/v0)^delta - (d_star/mezera)^2);

end
end