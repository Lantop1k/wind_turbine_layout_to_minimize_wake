function  objective= objfcn(x)

%Objective function

H=60;     %Hub height
rd=40;    %Rotor radius
Cy=0.88;  %Thrust coefficient
uo=12;    %free strea velocity
zo=0.3;   %surface roughness
Nt=20;    %Number of turbine


%induction factor
a=0.5/log(H/zo);

%compute the cost value
cost=Nt*(2/3 + (1/3)*exp(-0.00174*(Nt.^2)));

total_power=0;

%ccompute the reduction in the velocity
for i=1:Nt
    
    xi=x(i);
    ri=rd+a*xi;
    us(i)=uo*(1-2*a/((1+a*xi)/ri).^2);
    
    k(i)=(1-us(i)/uo).^2;
end

ui=uo*sqrt(sum(k));

%compute the total power
for i=1:Nt
    
    power=0.3*ui.^3;
    total_power=total_power+power;

end

%check for constraint
[~,bound] = constraint(x);

%set penalty for value out of the constraints
if bound ==1
     objective=100e3;
else
    objective=cost/ total_power;
end

end