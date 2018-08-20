% clear
clc
run settings.m

run ex2c
plot(x,r,'k-')
xlabel('$u$')
ylabel('$r$','Rotation',0,'HorizontalAlignment','right')
ylim([-0.3, 0.3])
saveas(gcf, strcat(figdir, 'bf_branch_u_r.png'))
plot(x,h,'k-')
xlabel('$u$')
ylabel('$h$','Rotation',0,'HorizontalAlignment','right')
saveas(gcf, strcat(figdir, 'bf_branch_u_h.png'))
plot(r,h,'k-')
xlabel('$r$')
ylabel('$h$','Rotation',0,'HorizontalAlignment','right')
xlim([-0.3, 0.3])
saveas(gcf, strcat(figdir, 'bf_branch_r_h.png'))
