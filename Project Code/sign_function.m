% Multi-Valued Sign function which
% y = sign_function(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    Conditions for the function     %%
%%%         y = 1 for x>0            %%%
%%%           = -1 for x<0           %%%
%%%           = [-1,1] for x=0       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generates random number between [-1,1] for x=0

function s = sign_function(x)
    s=sign(x);
    z = s==0;
    s(z)=1-2*rand(1,sum(z(:)));
end