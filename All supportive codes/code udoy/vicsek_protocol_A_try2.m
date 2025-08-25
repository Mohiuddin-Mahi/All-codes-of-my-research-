
function [theta_out,delete_inds,x_out,y_out] = vicsek_protocol_A_try2(lbox,vs,dt,r,eta,nbird,TMAX,num_leaders,wmat,beta,delta0,time_scale,r_array,randomize_followers,randomize_leaders,shared_ratio,randomize_L_every_two)

vx=zeros(nbird,TMAX);
vy=zeros(nbird,TMAX);

xb=rand(nbird,1).*lbox;
yb=rand(nbird,1).*lbox;

ang=pi.*2.*rand(nbird,1);
nsteps=1;
vxb=vs.*cos(ang);
vyb=vs.*sin(ang);
vx(:,nsteps)=vxb;
vy(:,nsteps)=vyb;



theta_out(:,1)=ang;
theta=ang;
x_out(:,1)=xb;
y_out(:,1)=yb;

delete_inds=zeros(TMAX,nbird,nbird);

logistic_points=(2*rand(nbird,1)-1)*delta0;
is_follower=ones(1,nbird);
is_follower(1:num_leaders)=0;



for nsteps=2:TMAX
    x_prev=xb;
    y_prev=yb;
    xb=xb+vxb.*dt;
    yb=yb+vyb.*dt;
    
    for bird1=nbird:-1:1
        
        
        [xb,yb]=boundary_conditions(xb,yb,bird1,lbox);
        
        
        
        [nearang,delete_mat]=calc_delete_inds_and_nearby(x_prev,y_prev,bird1,lbox,r,r_array,nbird);
        
        for d_ind=1:nbird
            
            delete_inds(nsteps,bird1,d_ind)=find(delete_mat(:,d_ind)==0,1)-1;
            
        end
        %THIS SHOULD BE CONSIDERED IN THE CASE OF more than 1 follower
        if randomize_leaders && randomize_followers
            
            [vxtemp,vytemp]=calc_nearby_average_A(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta,vs);
        end
        
        
        if randomize_followers && ~randomize_leaders
            if is_follower(bird1)
                
                [vxtemp,vytemp]=calc_nearby_average_A(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta,vs);
            else
                if randomize_L_every_two
                    if mod(nsteps,2)
                        [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta);
                    else
                        [vxtemp,vytemp]=calc_nearby_average_A(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta,vs);
                    end
                else
                    [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta);
                end
            end
        end
        
        if randomize_leaders && ~randomize_followers
            if is_follower(bird1)
                
                [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta);
                
            else
                
                [vxtemp,vytemp]=calc_nearby_average_A(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta,vs);
            end
            
        end
        
        if ~randomize_leaders && ~randomize_followers
            if is_follower(bird1)
                [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta);
            else
                
                if randomize_L_every_two
                    if mod(nsteps,2)
                        [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta);
                    else
                        [vxtemp,vytemp]=calc_nearby_average_A(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta,vs);
                    end
                else
                    [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,vx(nearang,nsteps-1),vy(nearang,nsteps-1),beta);
                end
                
            end
            
        end
        
        vtemp=[vxtemp,vytemp];
        curr_theta=calc_curr_theta(vxtemp,vytemp,vtemp);
        
        
        theta(bird1)=curr_theta;
        
        
        
    end
    logistic_points = logistic(logistic_points,delta0,ones(nbird,1));
    %     if randomize_leaders
    %         theta(1:num_leaders)=2*pi*rand;
    %     end
    ang=theta+(1-shared_ratio)*eta.*(rand(nbird,1)-0.5)  +shared_ratio*eta*(rand-0.5);
    
    if(mod(nsteps,time_scale)==0)
        ang=ang+logistic_points;
        
    end
    
    
    
    ang(ang>2*pi)=ang(ang>2*pi)-2*pi;
    ang(ang<0) = ang(ang<0) + 2*pi;
    
    vxb=vs.*cos(ang);
    vyb=vs.*sin(ang);
    vx(:,nsteps)=vxb;
    vy(:,nsteps)=vyb;
    
    theta_out(:,nsteps)=ang;
    x_out(:,nsteps)=xb;
    y_out(:,nsteps)=yb;
    
    
    
    
end




end

function [xb,yb]=boundary_conditions(xb,yb,bird1,lbox)

if(xb(bird1)<0);xb(bird1)=xb(bird1)+lbox; end
if (yb(bird1)<0);yb(bird1)=yb(bird1)+lbox;end
if (xb(bird1)>lbox);xb(bird1)=xb(bird1)-lbox;end
if (yb(bird1)>lbox);yb(bird1)=yb(bird1)-lbox;end

end

function [nearang,delete_mat]=calc_delete_inds_and_nearby(all_x,all_y,bird1,lbox,r,r_array,nbird)
[nearang,delete_mat]=mex_hyp_with_r(all_x,all_y,bird1,lbox,r,r_array,length(r_array));
delete_mat=reshape(delete_mat,length(r_array),nbird);

nearang=find(nearang);

end

function [vxtemp,vytemp]=calc_nearby_average_A(wmat,nearang,num_leaders,bird1,curr_vx_nearby,curr_vy_nearby,beta,vs)
curr_weights=wmat(bird1,:);
curr_bird=find(nearang==bird1);
weights0=curr_weights(nearang)';
weights=weights0;
[random_vx,random_vy]=erase_memory(vs);
curr_vx_nearby(curr_bird)=random_vx;
curr_vy_nearby(curr_bird)=random_vy;
if ~isequal(length(curr_vx_nearby),length(nearang))
    error('errored');
end
if bird1<=num_leaders
    vxtemp=(sum(weights.*curr_vx_nearby,1)+beta*1/sqrt(2))./(sum(weights,1)+beta);
    vytemp=(sum(weights.*curr_vy_nearby,1)+beta*1/sqrt(2))./(sum(weights,1)+beta);
else
    
    vxtemp=(sum(weights.*curr_vx_nearby,1))./(sum(weights,1));
    vytemp=(sum(weights.*curr_vy_nearby,1))./(sum(weights,1));
end


end

function [vxtemp,vytemp]=calc_nearby_average(wmat,nearang,num_leaders,bird1,curr_vx_nearby,curr_vy_nearby,beta)
curr_weights=wmat(bird1,:);
weights0=curr_weights(nearang)';
weights=weights0;


if bird1<=num_leaders
    vxtemp=(sum(weights.*curr_vx_nearby,1)+beta*1/sqrt(2))./(sum(weights,1)+beta);
    vytemp=(sum(weights.*curr_vy_nearby,1)+beta*1/sqrt(2))./(sum(weights,1)+beta);
else
    
    vxtemp=(sum(weights.*curr_vx_nearby,1))./(sum(weights,1));
    vytemp=(sum(weights.*curr_vy_nearby,1))./(sum(weights,1));
end


end

function curr_theta=calc_curr_theta(vxtemp,vytemp,vtemp)
if vytemp>=0
    curr_theta=acos(vxtemp/norm(vtemp));
else
    if vytemp<0
        curr_theta=2*pi-acos(vxtemp/norm(vtemp));
        
    end
end
end

function [random_vx,random_vy]=erase_memory(vs)
rand_theta=2*pi*rand();
random_vx=vs*cos(rand_theta);
random_vy=vs*sin(rand_theta);
end
