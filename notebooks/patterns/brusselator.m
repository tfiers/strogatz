% Physical size of the system
L=32;
% Parameters
D1=1;
D2=8;
oscillatory=false;
if(oscillatory==false)
  a=4.5; 
%
  b=7;
%
else
  a0=2*sqrt(D2*D1)/(D2-D1);
  a=0.75; 
  if(a>a0)
    error(sprintf('Oscillatory instability requires a < %f',a0));
  end
  b=1.6;
  bo=1+a^2; bc=(1+a*sqrt(D1/D2))^2;
  if(b<bo || b>bc)
    error(sprintf('Oscillatory instability requires %f <  b < %f',bo,bc));
  end
end
c=b/a;

% Spatial resolution:
%   - increase to improve performance,
%   - decrease to increase speed 
N=64;

% Timestep (has to be no more than 0.01 close to onset)
dt=0.01;
% Initial condition
if(0==0)
  t=0;
  U=a*ones(N)+0.001*randn(N);
  V=c*ones(N)+0.001*randn(N);
  Ut=[];
  %Ut=[t log(norm(U-a*ones(N))/N)];
end

% Wave numbers
q=zeros(N,1);
for k=1:N
  q(k)=(2*(k-1)/N-1)*pi*N/L;
end

%Matrix for implicit part of integration
Qmat=repmat(q.^2,1,N)+repmat((q.^2)',N,1);
Qmat2=spdiags(Qmat(:),0,N^2,N^2);
D2u=inv(speye(N^2)+dt*D1*Qmat2);
D2v=inv(speye(N^2)+dt*D2*Qmat2);

for n=1:30000
% Evolve in time t->t+dt
  u=fftshift(fft2(U));
  v=fftshift(fft2(V));
  t=t+dt;
  
  %implicit part of integration step
  u=reshape(D2u*u(:),N,N);
  v=reshape(D2v*v(:),N,N);
  
  U=real(ifft2(ifftshift(u)));
  V=real(ifft2(ifftshift(v)));

  U=U+dt*(a-(b+1)*U+U.^2.*V);
  V=V+dt*(b*U-U.^2.*V);

% Uncomment the following lines to impose Dirichlet BC
%  U(:,1)=a; U(:,N)=a;
%  U(1,:)=a; U(N,:)=a;

  Ut=[Ut;t log(norm(U-a)/N)];
%  Ut=[Ut;t U(N/2,N/2)-a];

% Do the plotting
  if(mod(n,200)==0 | n==1)
    subplot(2,2,1);
    rU=max([max(max(U))-a a-min(min(U))]);
    imagesc(U,[a-rU a+rU]);
    title('U');
    subplot(2,2,2);
    rV=max([max(max(V))-c c-min(min(V))]);
    imagesc(V,[c-rV c+rV]);
    title('V');
    subplot(2,2,4);
    imagesc(angle(U-a*ones(N)+j*(V-b/a*ones(N))));
    title('phase');
    subplot(2,2,3);
    plot(Ut(:,1),Ut(:,2));
    title('log(amplitude)');
    drawnow;
    disp(sprintf('t=%g: DU=%f DV=%f',t,norm(U-a*ones(N))/N,norm(V-b/a*ones(N))/N));
    % disp(sprintf(t,norm(U-a*ones(N))/N,norm(V-b/a*ones(N))/N));
  end
end
