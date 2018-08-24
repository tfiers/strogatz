% bifurcation diagram of the aero model
clear;
close all;
clc;

%% continuate along equilibrium point
prob = coco_prob();
prob = coco_set(prob, 'cont', 'h_max', 0.1);

prob = ode_isol2ep(prob, '', @aero, [0;0], {'V/Vc'}, [0.5]);

ep_data = coco(prob, 'aero_ep', [], 1, {'V/Vc'}, [0.1, 2]);

% visualize
p = coco_bd_col(ep_data, 'V/Vc');
x = coco_bd_col(ep_data, 'x');

ustab = coco_bd_col(ep_data, 'ep.test.USTAB');
ustab_idxs = find(ustab > 0);
stab_idxs = find(ustab == 0);

figure(1), clf, hold on
plot(p(stab_idxs), x(1,(stab_idxs)), 'b.');
plot(p(ustab_idxs), x(1,(ustab_idxs)), 'r.');


%% continuate periodic orbit starting from the hopf bifurcation
hopfbif = coco_bd_labs(ep_data, 'HB');

prob = coco_prob();
prob = coco_set(prob, 'coll', 'NTST', 12);         % ???
prob = coco_set(prob, 'cont', 'NAdapt', 5);       % ???
prob = coco_set(prob, 'cont', 'h0', 80);         % ???
prob = coco_set(prob, 'cont', 'h_max', 100);      % ???
prob = coco_set(prob, 'cont', 'ItMX', 400);       % ???
prob = coco_set(prob, 'corr', 'TOL', 1e-4);       % ???

prob = ode_HB2po(prob, '', 'aero_ep', hopfbif);

po_data = coco(prob, 'aero_po', [], 1, 'V/Vc', [0.9 2]);

% visualize
p = coco_bd_col(po_data, 'V/Vc');
nrm = coco_bd_col(po_data, '||po.orb.x||_{L_2[0,T]}');
A1 = 0.04695;
Vc = 2/A1;
nrm = nrm / Vc;

ustab = coco_bd_col(po_data, 'po.test.USTAB');
ustab_idxs = find(ustab > 0);
stab_idxs = find(ustab == 0);

figure(1), hold on
plot(p(stab_idxs), nrm(1,(stab_idxs)), 'g.');
plot(p(ustab_idxs), nrm(1,(ustab_idxs)), 'r.');

sn_idxs = coco_bd_idxs(po_data, 'SN');  % get saddle-node bif.
plot(p(sn_idxs), nrm(sn_idxs), 'ko', 'MarkerSize', 6);

xlabel('V/Vc');
ylabel('A/Vc');