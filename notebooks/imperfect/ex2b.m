close all;

% fixed value for h
% h_fix = -0.1;

%% find first branch
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob = ode_isol2ep(prob, '', @ex2_system, 0, {'r', 'h'}, [-1, h_fix]);
bd1 = coco(prob, 'tcbif', [], 1, {'r'}, [-1, 1]);


% visualize first branch
figure(1); clf; hold on;
x = coco_bd_col(bd1, 'x');
r = coco_bd_col(bd1, 'r');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), 'b.');
plot(r(ustab_idxs), x(ustab_idxs), 'r.');
ylim([-2.5,2.5]);

xlabel('$r$'); ylabel('$u$','Rotation',0,'HorizontalAlignment','right');

%% find second branch
% Since we know about the pitchfork bifurcation, we can suspect that the
% imperfection broke the equilibrium branch and that there is a second
% branch.

prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
% prob = coco_set(prob, 'cont', 'h_min', 0.01);
% prob = coco_set(prob, 'cont', 'h_max', 0.5);
% prob = coco_set(prob, 'corr', 'ItMX', 10);

prob = ode_isol2ep(prob, '', @ex2_system, 0.3, {'r', 'h'}, [0.1, h_fix]);
bd2 = coco(prob, 'tcbif', [], 1, {'r'}, [-1, 1]);

x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');

ustab = coco_bd_col(bd2, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), 'b.');
plot(r(ustab_idxs), x(ustab_idxs), 'r.');

idx = coco_bd_idxs(bd2, 'SN');
plot(r(idx), x(idx), 'ro','markerfacecolor','r','markersize',9);
