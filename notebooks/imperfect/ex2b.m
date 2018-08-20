% close all;

% fixed value for h
% h_fix = -0.1;

%% find first branch
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'h_min', h_min);
prob = coco_set(prob, 'cont', 'h_max', h_max);
prob = coco_set(prob, 'cont', 'ItMX', cont_ItMX);
prob = coco_set(prob, 'corr', 'ItMX', corr_ItMX);

prob = ode_isol2ep(prob, '', @ex2_system, 0, {'r', 'h'}, [-1, h_fix]);
bd1 = coco(prob, 'tcbif', [], 1, {'r'}, [-1, 1]);


% visualize first branch
figure(); clf; hold on;
x = coco_bd_col(bd1, 'x');
r = coco_bd_col(bd1, 'r');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), style_stab);
plot(r(ustab_idxs), x(ustab_idxs), style_unstab);
ylim([-2.5,2.5]);

xlabel('$r$'); ylabel('$u$','Rotation',0,'HorizontalAlignment','right');

%% find second branch
% Since we know about the pitchfork bifurcation, we can suspect that the
% imperfection broke the equilibrium branch and that there is a second
% branch.

prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'h_min', h_min);
prob = coco_set(prob, 'cont', 'h_max', h_max);
prob = coco_set(prob, 'cont', 'ItMX', cont_ItMX);
prob = coco_set(prob, 'corr', 'ItMX', corr_ItMX);

prob = ode_isol2ep(prob, '', @ex2_system, guess, {'r', 'h'}, [0.1, h_fix]);
bd2 = coco(prob, 'tcbif', [], 1, {'r'}, [-1, 1]);

x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');

ustab = coco_bd_col(bd2, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(r(stab_idxs), x(stab_idxs), style_stab);
plot(r(ustab_idxs), x(ustab_idxs), style_unstab);

idx = coco_bd_idxs(bd2, 'SN');
plot(r(idx), x(idx), 'ro','markerfacecolor','r','markersize',9);
