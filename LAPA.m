clear;
close all;

nx=50;
ny=50;
V=zeros(nx,ny);

max_iterations=300;
top_val=0;
bottom_val=0;
left_val=1;
right_val=1; % Setting this bc to 1 mirrors the previous behaviour so it occurs on both the left and right, looking like a saddle

% Set boundary conditions
V(1,:)=left_val;   
V(nx,:)=right_val;  
V(:,1)=top_val;   
V(:,ny)=bottom_val;  

% Iteratively solve
for k=1:max_iterations   
    for x=2:nx-1 
      for y=2:ny-1
          V(x,y)=(V(x-1,y)+V(x+1,y)+V(x,y-1)+V(x,y+1))/4;          
      end
    end  
    
    % Plot voltage
    subplot(2,1,1);
    %surf(V) % Appears as expected, a gentle slope in from left to right, with a large slope in the top left and bottom left 
    surf(imboxfilt(V,3))
    
    % Plot E field (/w surf)
    subplot(2,1,2);
    %[Ex,Ey]=gradient(-V);
    [Ex,Ey]=gradient(-imboxfilt(V,3));
    surf(Ex,Ey);    
    
    pause(0.0001)    
end

% plot E field (/w quiver)
figure()
quiver(Ex,Ey);



