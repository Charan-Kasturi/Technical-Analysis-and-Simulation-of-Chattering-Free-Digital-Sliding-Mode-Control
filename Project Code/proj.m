% Projection Function
% Gives the projection of x on [-1,1]

function r=proj(x)
    r = max(-1,min(1,x));
end
