clear;
close all;

ep_data = coco_bd_read('aero_ep');
po_data = coco_bd_read('aero_po');

p = coco_bd_col(ep_data, 'V/Vc');
x = coco_bd_col(ep_data, 'x');

% visualize
figure(2), clf, hold on
plot3(p, x, zeros(length(p),1));

nb_labs = coco_bd_col(po_data, 'LAB');
for lab=1:nb_labs{end}
    sol = po_read_solution('', 'aero_po', lab);
    N = length(sol.xbp(:,1));
    plot3(sol.p*ones(N,1), sol.xbp(:,1), sol.xbp(:,2));
end
grid on, view(30,15), box on
xlabel('V/Vc');
ylabel('$y/Vc$');
zlabel('$\dot{y}/Vc$');