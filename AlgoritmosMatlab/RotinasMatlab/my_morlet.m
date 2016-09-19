%morlet function (?)

function m = morlet(t,params)

    sigma = params;

    m=pi^-0.25*exp(-i*sigma.*t-0.5*t.^2);

end