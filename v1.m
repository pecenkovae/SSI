function v_first = v1(t,v,road)
% INPUT:
%   t...cas
%   v...rychlost v pripade konstatni rychlosti
% OUTPUT:
%   v_first...rychlost prvniho vozidla
switch road
    case 'main'

        v_first = v;

    case 'side'
global A B v_poc
    
    v_first = v_poc + A*sin(B*t);
end
    
end
   