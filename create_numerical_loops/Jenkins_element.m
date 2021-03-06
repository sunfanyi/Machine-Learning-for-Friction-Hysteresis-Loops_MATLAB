function [F, mu, E] = Jenkins_element(kt, x, CL, mu)

F = zeros(size(x));
slip = zeros(size(x,1),1);
flag_slip = zeros(size(x));

for t = 1:size(x,2)
    F(:,t) = kt .* (x(:,t) - slip);

    % the loops which CL is reached at t:
    idx = abs(F(:,t)) > CL;
    
    F(idx,t) = (CL(idx) .* sign(F(idx,t)));
    slip(idx) = (x(idx,t) - F(idx,t)./kt(idx));
    flag_slip(idx,t) = 1;
end

E = polyarea(x, F, 2)*10^(-6);

% no slip occurs means no energy dissipated thus zero mu
E(all(~flag_slip,2)) = 0;
mu(all(~flag_slip,2)) = 0;

end

% visualise the chattering distribution:
% hist((0.9+0.2*rand(5000,1)).*abs(1+0.1*randn(5000,1)),100)





% function F = Jenkins_element(kt,x,CL)
% 
% slip = 0;
% for t = 1:length(x)
%     F(t) = kt * (x(t)-slip);
%     if abs(F(t)) > CL
%         F(t) = CL * sign(F(t));
%         slip = x(t)-F(t)/kt;
%     end
% end
