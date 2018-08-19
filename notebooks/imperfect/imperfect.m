% clear
clc
% Get factory values with: get(0, 'factory')
% Get what you've changed with: get(0, 'default')
set(0, 'DefaultLineLineWidth', 3)
set(0, 'DefaultLineMarkerSize', 12)
set(0, 'DefaultAxesFontSize', 20)
set(0, 'DefaultTextInterpreter', 'latex')


% r_fix = -1
% run ex2a
% saveas(gcf, 'r_-1.png')

% r_fix = 0
% run ex2a
% saveas(gcf, 'r_0.png')

% r_fix = 1
% run ex2a
% saveas(gcf, 'r_1.png')


% h_fix = -0.1;
% run ex2b
% saveas(gcf, 'h_neg.png')

% h_fix = 0;
% run ex2b
% saveas(gcf, 'h_0.png')

% h_fix = +0.1;
% run ex2b
% saveas(gcf, 'h_pos.png')


run ex2c
plot(x,r,'k.')
xlabel('$u$')
ylabel('$r$','Rotation',0,'HorizontalAlignment','right')
ylim([-0.2, 0.4])
saveas(gcf, 'bf_branch_u_r.png')
plot(x,h,'k.')
xlabel('$u$')
ylabel('$h$','Rotation',0,'HorizontalAlignment','right')
saveas(gcf, 'bf_branch_u_h.png')
plot(r,h,'k.')
xlabel('$r$')
ylabel('$h$','Rotation',0,'HorizontalAlignment','right')
xlim([-0.2, 0.4])
saveas(gcf, 'bf_branch_r_h.png')

