function [x,bound] = constraint(x)

%Constaint functions
Nt=20;   %Number of turbine

%extract y coordinate
y=x(Nt+1:end);

%initial the zeros distance 
dist=zeros(Nt,Nt);
s=200; %minimum spacing of 500m
bound=0;

%calculate the distance between the turbine and check for minimum spacing
for i=1:Nt
      for j=1:Nt         
          dist(i,j)=sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);          
          if dist(i,j)<s && i~=j
             bound=1; 
          end
      end
end
  
end