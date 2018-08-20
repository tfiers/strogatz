clear
clc
run settings.m

guess = 0.3
style_stab = 'b.'
style_unstab = 'r.'

h_fix = -0.0025
h_min = 0.01
h_max = 0.2
cont_ItMX = 100
corr_ItMX = 10
run ex2b
saveas(gcf, strcat(figdir, 'close.png'))

h_fix = -0.0005
run ex2b
saveas(gcf, strcat(figdir, 'very_close_coarse.png'))

h_max = 0.05
run ex2b
saveas(gcf, strcat(figdir, 'very_close_fine.png'))


h_fix = -0.0025
h_min = 0.2
h_max = 0.2
run ex2b
saveas(gcf, strcat(figdir, 'two_SN.png'))
