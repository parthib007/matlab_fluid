clear
close all

%% 1. Inialise the mesh
[p,e,t] = importMeshGmsh('cylinder.msh');
displayMesh2D(p,t)

[p,e,t,nVnodes,nPnodes,indices] = convertMeshToSecondOrder(p,e,t);

%% Flow properties
nu = 0.01;

%% Initialise the solution
[u,convergence] = initSolution(p,t,[1,0],0);
maxres = 1e-5;
maxiter = 50;

%% Iterative loop
for iter = 1:maxiter
    [NS,F] = assembleNavierStokesMatrix2D(p,e,t,nu,u(indices.indu),u(indices.indv),'nosupg');
    [NS,F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,10,'inlet',[1,0]);
    [NS,F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,13,'wall');
    [NS,F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,12,'slipAlongX');

    [stop,convergence] = computeResiduals(NS,F,u,size(p),convergence,maxres);

    plotResiduals(convergence,2);

    if (stop)
        break;
    end

    u = NS\F;
end

pressure = generatePressureData(u,p,t);

%% Visualise
figure(3)
displaySolution2D(p,t,u(indices.indu),'x-velocity field(m/s)')

figure(4)
displaySolution2D(p,t,u(indices.indp),'pressure (p/rho)')

%% Post analysis
[vx,lp,le] = extractDataAlongLine(p,t,u,[0 0],[-2 2], 100,15);
figure(6)
scatter(vx,lp(2,:)')
title('x-velocity at x=0')
xlabel('vx (m/s)')
ylabel('y(m)')
grid on

[p_integral,p_average] = boundaryIntegral2D(p,e,pressure,10)