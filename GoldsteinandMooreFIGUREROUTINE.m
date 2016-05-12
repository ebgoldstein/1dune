%This code plots the results of the stabiltiy diagram, yielding the 2
%figures in the manuscript. 

%Written by EBG 11/2014

%The MIT License (MIT)
%Copyright (c) 2016 Evan B. Goldstein

%Copyright held by:
% Evan B. Goldstein, Ph.D.
% Postdoctoral Associate, Department of Geological Sciences
% The University of North Carolina at Chapel Hill
% Chapel Hill, NC 27599 USA
% http://ebgoldstein.wordpress.com
% twitter: @ebgoldstein
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%FIGURE PLOTTING ROUTINE
clear all
close all
clc
load ImpulsiveStability

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STABILITY DIAGRAM
%plot up the number of Fixed points for each region of omega-zeta space

figure
subplot(2,2,1)
imagesc(FP');
%colorbar
colormap(bone)
caxis([0 2])
%clabel('# of FPs')
%title('number of stable solutions')
% ylabel('R* (R/D_m_a_x)', 'FontSize',14)
% xlabel('S* (S/r)', 'FontSize',14)
ylabel('R*', 'FontSize',14)
xlabel('S*', 'FontSize',14)
axis xy
set(gca,'XTick',[100,200,300,399])
set(gca,'XTickLabel',{'5','10','15','20'}, 'FontSize',14)
set(gca,'YTick',[20,40,60,80,100])
set(gca,'YTickLabel',{'0.2','0.4','0.6','0.8','1'}, 'FontSize',14)
axis square

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%locations to plot bifurcation diagrams
loc1=10;
loc2=30;
loc3=80;

vl1=[loc1,loc1];
vl2=[loc2,loc2];
vl3=[loc3,loc3];
omlength=[0,om];


hold on
plot(omlength,vl1,'--k')
plot(omlength,vl2,'--k')
plot(omlength,vl3,'--k')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%find nonzero locations of manifold
%replaces all instances of '0'  with 'NaN'
M=manifold;
M(M==0) = nan;

%the unstabel FP @ D=0
USFP=zeros(1,length(FPmax(:,loc1)));

%%%%%%%
minheight=linspace(1,om,length(omegaV));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,2)
plot(FPmax(1:396,loc1),'k','LineWidth',2)
hold on
plot(398:(om),FPmax(398:(om),loc1),'k','LineWidth',2)
plot(FPmin(:,loc1),'k','LineWidth',2)
plot(M(1:396,loc1),'--k','LineWidth',2)
plot(USFP,'--k','LineWidth',2)
set(gca,'XTick',[100,200,300,400])
set(gca,'XTickLabel',{'5','10','15','20'}, 'FontSize',14)
ylabel('D*', 'FontSize',14)
xlabel('S*', 'FontSize',14)
%xlabel('S* (S/r)', 'FontSize',14)
title('R*=0.1', 'FontSize',14)
ylim([-0.01 1])
axis square

subplot(2,2,3)
plot(FPmax(1:108,loc2),'k','LineWidth',2)
hold on
plot(109:(om),FPmax(109:(om),loc2),'k','LineWidth',2)
plot(FPmin(:,loc2),'k','LineWidth',2)
plot(M(:,loc2),'--k','LineWidth',2)
plot(USFP,'--k','LineWidth',2)
set(gca,'XTick',[100,200,300,400])
set(gca,'XTickLabel',{'5','10','15','20'}, 'FontSize',14)
ylabel('D*', 'FontSize',14)
xlabel('S*', 'FontSize',14)
%xlabel('S* (S/r)', 'FontSize',14)
title('R*=0.3', 'FontSize',14)
ylim([-0.01 1])

axis square

subplot(2,2,4)
plot(FPmax(1:27,loc3),'k','LineWidth',2)
hold on
plot(28:(om),FPmax(28:(om),loc3),'k','LineWidth',2)
plot(FPmin(:,loc3),'k','LineWidth',2)
plot(M(:,loc3),'--k','LineWidth',2)
plot(USFP,'--k','LineWidth',2)
set(gca,'XTick',[100,200,300,400])
set(gca,'XTickLabel',{'5','10','15','20'}, 'FontSize',14)
ylabel('D*', 'FontSize',14)
xlabel('S*', 'FontSize',14)
%xlabel('S* (S/r)', 'FontSize',14)
title('R*=0.8', 'FontSize',14)
ylim([-0.01 1])


axis square


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dattractor=0:0.01:1;
% 
% omegaE=1;
% FinalDA=Dattractor./(Dattractor+(exp(-(1/omegaE)).*(1-Dattractor)));
% 
% Growth1=FinalDA-Dattractor;
% 
% omegaE=5;
% FinalDA=Dattractor./(Dattractor+(exp(-(1/omegaE)).*(1-Dattractor)));
% 
% Growth2=FinalDA-Dattractor;
% 
% omegaE=10;
% FinalDA=Dattractor./(Dattractor+(exp(-(1/omegaE)).*(1-Dattractor)));
% 
% Growth3=FinalDA-Dattractor;
% 
% figure
% plot(Dattractor,Growth1,'r','LineWidth',2)
% hold on
% plot(Dattractor,Growth2,'k','LineWidth',2)
% plot(Dattractor,Growth3,'b','LineWidth',2)
% xlabel('D*; Dune Height', 'FontSize',14)
% ylabel('G*; Dune Growth', 'FontSize',14)
% %  a = get(gca,'XTickLabel');
% %  %set(gca,'XTickLabel',a, 'FontSize',14)
%  a = get(gca,'YTickLabel');
%  set(gca,'YTickLabel',a, 'FontSize',14)
% 
% 
% %ADJUST THE LEGEND
% h =legend('\Omega = 1','\Omega = 5','\Omega = 10')
% set(h,'FontSize',14);
% legend(gca, 'boxoff')
% 
% b=findobj(h,'type','line','linestyle','-');
% set(b,'visible','off');
% 
% hText = findobj(h, 'type', 'text');
% set(hText(1),'color', 'b');
% set(hText(2),'color', 'k');
% set(hText(3),'color', 'r');
% 
% 
% 
