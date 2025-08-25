
lbox=10;
TMAX=4000;

load('symbols/symbols_r3_box10_coup_10_noise_1.mat');
figure
v=VideoWriter('movie/symbols_r3_box10_coup_10_noise_1.avi');
v.FrameRate=6;
v.Quality=20;
open(v)

for t=2800:TMAX
    figure
    quiver(x_data{1,1}(1,t),y_data{1,1}(1,t),0.5*cos(symbols_real{1,1}(1,t)),...
        0.5*sin(symbols_real{1,1}(1,t)),'AutoScale','on','AutoScaleFactor',1,'MaxHeadSize',3,'color','r','linewidth',3);
    hold on
    for j=2
        quiver(x_data{1,1}(2,t),y_data{1,1}(2,t),0.5*cos(symbols_real{1,1}(2,t)),...
        0.5*sin(symbols_real{1,1}(2,t)),'AutoScale','on','AutoScaleFactor',1,'MaxHeadSize',3,'color','k','linewidth',3);
        hold on
    end
    for k=3
        quiver(x_data{1,1}(3,t),y_data{1,1}(3,t),0.5*cos(symbols_real{1,1}(3,t)),...
        0.5*sin(symbols_real{1,1}(3,t)),'AutoScale','on','AutoScaleFactor',1,'MaxHeadSize',3,'color','g','linewidth',3);
        hold on
    end

    axis tight;
%     set(gcf,'Units','Normalized','outerPosition',[0 0 1 1]);
    axis equal
    set(gca,'xlim',[0 lbox])
    set(gca,'ylim',[0 lbox])
    title(['Time steps: ',num2str(t)])
%     title(['Time steps: ',num2str(t),';w = 0.6 ; \eta = 0.9\pi'])
    legend('$~X$','$~Y$','$~Z$','location','northeast','interpreter','latex')
    set(gca,FontSize=12);
    shg
    g=getframe(gcf);

    writeVideo(v,g);
    close all;
end
close(v)
