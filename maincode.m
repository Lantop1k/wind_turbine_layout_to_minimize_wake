clc
clear 
close

global state_record

%using PSO parameters
pop=50;  %population size
maxit=200; %maximum iteration

%plant parameters
H=60;    % Hub height
rd=40;   %Rotor radius
Cy=0.88; %Thrust coefficient
uo=12; %free strea velocity
zo=0.3; %surface roughness
Nt=20; %Number of turbine

fun =@(x) objfcn(x); %objective function

lb=zeros(1,2*Nt); %lower bound for optimization variables
ub=2e3*ones(1,2*Nt); %upper bound for parameter

%using PSO Algorithm
options = optimoptions('particleswarm','SwarmSize',pop,'Display','iter','MaxStallIterations',maxit,...
    'MaxIterations',maxit,'FunctionTolerance',1e-100, 'OutputFcn',@psooutfun);

variables = particleswarm(fun,2*Nt,lb,ub,options);
clear psooutfun
record = psooutfun();

%induction factor
a=0.5/log(H/zo);

%extract the optimized x and y coordinates
x=variables(1:Nt);  %x coodinates
y=variables(Nt+1:end); %y coordinates

%plot the graph
figure(1)
plot(x,y,'o', 'MarkerSize',10,'MarkerFaceColor','r')
xlabel('x [m]')
ylabel('y [m]')
grid on
title('Optimum Farm Layout for Turbine')

%function to record iteration output
function stop= psooutfun(options,state)
    global state_record 
   
    if isempty(state_record)
      state_record = [];
    end
    if nargin == 0
      state = state_record;
      options = [];
      stop = [];
    else
     [power,cost]=objective(options.bestx);
     state_record = vertcat(state_record, [power,cost]);
     stop = false;
     state=state_record;
    end
    
end
