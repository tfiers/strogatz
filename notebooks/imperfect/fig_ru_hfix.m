% clear
clc
run settings.m

style_stab = 'b-'
style_unstab = 'r-'
h_min = 0.01
h_max = 0.2
cont_ItMX = 100
corr_ItMX = 10
guess = 0.3
h_fix = -0.1;
run ex2b
saveas(gcf, strcat(figdir, 'h_neg.png'))

h_fix = 0;
run ex2b
saveas(gcf, strcat(figdir, 'h_0.png'))

guess = -0.3
h_fix = +0.1;
run ex2b
saveas(gcf, strcat(figdir, 'h_pos.png'))
