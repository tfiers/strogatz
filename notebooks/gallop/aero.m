function [ dxdt ] = aero( x, p )

    A1 = 0.04695;
    A3 = 8.932e-4;
    A5 = 1.015e-5;
    A7 = 2.9553e-8;
    m = 1;
    ro = 1;
    r = 1;
    k = 100;
    a = 1;
    
    Vc = 2/A1;
    V = p.*Vc;
    
    C = @(x) A1.*x - A3.*(x).^3 + A5.*(x).^5 - A7.*(x).^7;
    
    dxdt(1,:) = x(2,:);
    dxdt(2,:) = 1./(2.*m).*ro.*V.^2.*a.*C(x(2,:)./V) - r./m.*x(2,:) - k./m.*x(1,:);
    
end

