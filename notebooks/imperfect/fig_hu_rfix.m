% clear
clc
run settings.m

h_max = 0.2

r_fix = -1
run ex2a
saveas(gcf, strcat(figdir, 'r_-1.png'))

r_fix = 0
run ex2a
saveas(gcf, strcat(figdir, 'r_0.png'))

r_fix = 1
run ex2a
saveas(gcf, strcat(figdir, 'r_1.png'))
