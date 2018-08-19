clear;
close all;

%% Find a initial fold point to start the continuation from
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

prob = ode_isol2ep(prob, '', @ex2_system, 0.3, {'r', 'h'}, [1, 0.1]);
bd1 = coco(prob, 'ex2_3_initial_fold', [], 1, {'r'}, [-1, 1]);


%% Continuate along the branch of fold points
prob = coco_prob();
prob = coco_set(prob, 'ode', 'vectorized', false);

fold = coco_bd_labs(bd1, 'SN');

prob = ode_SN2SN(prob, '', 'ex2_3_initial_fold', fold(1));
bd2 = coco(prob, 'ex2_3_fold_curve', [], 1, {'r', 'h'}, {[0, 2], [-0.1, 0.1]});

x = coco_bd_col(bd2, 'x');
r = coco_bd_col(bd2, 'r');
h = coco_bd_col(bd2, 'h');

plot3(x,r,h,'k.');
xlabel('x'); ylabel('r'); zlabel('h');
grid on