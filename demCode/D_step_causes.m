function [DEM_t,DEMv_x] = D_step_causes(A,D_A,B,Da,Bt,Ct,V0y,W0,Y_embed,real_cause,...
    t,sam_time,nt,nv,ny,p_brain,d_brain)

state_sp_v = ss(Da - Ct'*V0y*Ct - D_A'*W0*D_A, ...
                [Ct'*V0y D_A'*W0*Bt], zeros(1,size(Da,2)), ...
                zeros(1,(p_brain+1)*ny+(d_brain+1)*nv));
state_sp_v = c2d(state_sp_v,sam_time,'zoh');

% Embed the known causes
V_embed = zeros(nv*(d_brain+1),nt);
for i = 1:nt
    V_embed(:,i) = embed_Y(real_cause,d_brain+1,t(i),sam_time);
end
Y_embed(ny*(p_brain+1)+1:end,:) = V_embed;

% Perform state estimation
DEMv_x = zeros(nt,size(state_sp_v.C,2));
for i = 2:nt
    DEMv_x(i,:)=(state_sp_v.A*DEMv_x(i-1,:)' + state_sp_v.B*Y_embed(:,i))';
end

DEM_t = t;

% Plot generalized states
figure('Name','Generalized states');
nx = size(D_A,1)/(p_brain+1);
for i = 1:p_brain+1
    subplot(p_brain+1,1,i);
    plot(DEM_t,DEMv_x(:,(i-1)*nx+1:i*nx));
end

% Plot generalized outputs
figure('Name','Generalized outputs');
for i = 1:p_brain+1
    subplot(p_brain+1,1,i);
    plot(DEM_t,Y_embed((i-1)*ny+1:i*ny,:));
end

% Plot generalized inputs
figure('Name','Generalized inputs');
for i = 1:d_brain+1
    subplot(d_brain+1,1,i);
    plot(DEM_t,Y_embed(ny*(p_brain+1)+(i-1)*nv+1:ny*(p_brain+1)+i*nv,:));
end

end