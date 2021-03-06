% close all;

% fixed value for r
% r_fix = 0.5;

%% find first branch
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'h_max', h_max);

prob = ode_isol2ep(prob, '', @ex2_system, 0, {'r', 'h'}, [r_fix, 0]);
bd1 = coco(prob, 'tcbif', [], 1, {'h'}, [-2, 2]);


%% visualize first branch
figure(1); clf; hold on;
x = coco_bd_col(bd1, 'x');
h = coco_bd_col(bd1, 'h');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
stab_idxs_A = stab_idxs(1:length(stab_idxs)/2);
stab_idxs_B = stab_idxs(length(stab_idxs)/2+1:end);
plot(h(ustab_idxs), x(ustab_idxs), 'r-');
plot(h(stab_idxs_A), x(stab_idxs_A), 'b-');
plot(h(stab_idxs_B), x(stab_idxs_B), 'b-');
ylim([-2.5,2.5]);

idx = coco_bd_idxs(bd1, 'SN');
plot(h(idx), x(idx), 'ro', 'markerfacecolor','r','markersize',9);
xlabel('$h$'); ylabel('$u$','Rotation',0,'HorizontalAlignment','right');