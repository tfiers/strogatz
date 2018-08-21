% close all;

% fixed value for d
d_fix = 0;
h_max = 0.1;
xy_0 = [0.4, 0.12];
c_0 = 0.4;

%% find first branch
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);
prob = coco_set(prob, 'cont', 'h_max', h_max);

prob = ode_isol2ep(prob, '', @predprey, xy_0, {'c', 'd'}, [c_0, d_fix]);
bd1 = coco(prob, 'tcbif', [], 1, {'c'}, [-0.1, 1.5]);


%% visualize first branch
figure(1); clf; hold on;
x = coco_bd_col(bd1, 'x');
c = coco_bd_col(bd1, 'c');

ustab = coco_bd_col(bd1, 'ep.test.USTAB');
ustab_idxs = find(ustab == 1);
stab_idxs = find(ustab == 0);
plot(h(ustab_idxs), x(ustab_idxs), 'r-');
plot(h(stab_idxs), x(stab_idxs), 'b-');

% ylim([-2.5,2.5]);

idx = coco_bd_idxs(bd1, 'SN');
plot(h(idx), x(idx), 'ro', 'markerfacecolor','r','markersize',9);
xlabel('$x$'); ylabel('$c$','Rotation',0,'HorizontalAlignment','right');
