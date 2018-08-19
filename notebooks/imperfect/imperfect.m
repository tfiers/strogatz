% clear
clc
set(0, 'DefaultLineLineWidth', 3)
set(0, 'DefaultLineMarkerSize', 12)
set(0, 'DefaultAxesFontSize', 20)

r_fix = -1
run ex2a
saveas(gcf, 'r_-1.png')

r_fix = -0.5
run ex2a
saveas(gcf, 'r_-0_5.png')

r_fix = 0
run ex2a
saveas(gcf, 'r_0.png')

r_fix = 0.5
run ex2a
saveas(gcf, 'r_0_5.png')

r_fix = 1
run ex2a
saveas(gcf, 'r_1.png')
