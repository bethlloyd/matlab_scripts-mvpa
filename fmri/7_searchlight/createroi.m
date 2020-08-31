%written by Tjerk Gutteling, 2013
%creates spherical ROIs with a certain radius
x=0
y=0
z=0
radius=60;
vx_size=[2.75,2.75,3];

function [roi] = createroi(x,y,z,radius,vx_size)

roi=[];

for a=(x-radius):(x+radius)
    
    for b=(y-radius):(y+radius)
        
        for c=(z-radius):(z+radius)
            
            if pdist([x,y,z;(a*vx_size(1)),(b*vx_size(2)),(c*vx_size(3))])<radius
                
                roi = [roi ; a,b,c];
                
            end
            
        end
        
    end
    
end

roi=unique(roi,'rows');

end