%This is a code written to compute the stability diagram of the impulsive
%differential
%equation that describes dune growth (logistic) and dune destruction
%(storms).
%The stability diagram is computed using a difference equation, akin to
% 'strobing' the impulsive differential equation at a given
%interval (i.e., the (nondimensional) storm freqency).  

%The code uses the solution to the nondimensional logistic equation and a
%new equation for dune destruction (derived with Machine Learning) to compute
%foredune height after a given time period (the NonDimensional storm 
%frequency). 

%This model operates for a set range of values for 
%omega (dune growth rate/storm frequency) and 
%zeta (high water during each storm/max dune height). Using these values it 
%computes the time trajectory of dune height using different ICs. 
%By averaging the final part of the trajectory, the code is able to 
%determine where the stable dune heights are. 

%Written by EBG from 9/2014 to 11/2014

%Creative Commons 
%Attribution-NonCommercial-ShareAlike 
%3.0 Unported

%Copyright held by:
% Evan B. Goldstein, Ph.D.
% Postdoctoral Associate, Department of Geological Sciences
% The University of North Carolina at Chapel Hill
% Chapel Hill, NC 27599 USA
% http://ebgoldstein.wordpress.com
% twitter: @ebgoldstein

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Determine the actual steps, in ND space, for Omega and Zeta range
omegaV=0.1:0.05:20;
zetaV=0.01:0.01:1;

%Determine the steps for the initial conditions (range from 0 to 1)
icsteps=0.01;
initCV=0.01:icsteps:1;

%ML constants
C1=8.05;
C2=4.33;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%preallocate space for matricies that record the number of fixed points,
%maximum height of dunes (max FP) and the minimum height of dunes (minFP).
FPlocation=length(initCV);
FP=nan(length(omegaV),length(zetaV));
FPmin=nan(length(omegaV),length(zetaV));
FPmax=nan(length(omegaV),length(zetaV));
FPmanifold=nan(length(omegaV),length(zetaV));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Loop through the omega vector
for om=1:length(omegaV)
    omega=omegaV(om);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %output to count time..
    PercentDone=omega/max(omegaV)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %SET the model time stepTIME
    dt=1/omega;
    TMAX=10000*dt;
    tstar=0:dt:TMAX;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Loop through the zeta vector
    for ze=1:length(zetaV)
        zeta=zetaV(ze);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Loop through the initial conditions vector
        for IC=1:length(initCV)
            initC=initCV(IC);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %set the initial condition as the first place in the vector
            clear Dstar
            Dstar(1)=initC;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Loop through the ICs and solve the equation
            for t=2:1:length(tstar);
                
                %GROWTH
                %Solution to the nondimensional logistic equation
                G=Dstar(t-1)/(Dstar(t-1)+(exp(-(dt))*(1-Dstar(t-1))));
                
                %DESTRUCTION
                %ND Storm eqn
                S=zeta/(C1+((zeta/G)*((zeta/G)-C2)));

                %resultant final dune height @ strobe period, in this case
                %just after the storm hits
                Dstar(t)=G-S;
                
                if Dstar(t-1)<=0
                    error('dstar less than zero')
                end

                
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Find the mean of the last 1/4 of the timeseries: 
            %(the location of the attracting fixed point) 
            FPlocation(IC)=mean(Dstar(round(length(Dstar)/4 ):length(Dstar)));   
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %FIND THE FIXED POINTS
        %Round the Fixed point locations and range to the 4th decimal
        FPlocation = round(FPlocation*10000)/10000;
        %Count the unique values of FP locations
        %(to determine multistability)
        FP(om,ze)=length(unique(FPlocation));
        %Find the max dune height
        FPmax(om,ze)=max(unique(FPlocation));
    
        %If there are 2 FPs..
        %1) Find the manifold by looking for the first occurence of the
        %'max' dune height.
        %2) find the minumum dune height
        
        if FP(om,ze)>1;
            %manifold
            FPmanifold(om,ze)=icsteps*min(find(FPlocation==max(unique(FPlocation))));
            %min dune height
            FPmin(om,ze)=min(unique(FPlocation));
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change NaN to 0 in manifold plot
manifold=FPmanifold;
manifold(isnan(FPmanifold))=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SAVE ALL THE WORK!!
save ImpulsiveStability
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOTTING ROUTINE
%plot up the number of Fixed points for each region of omega-zeta space
imagesc(FP);
%colorbar
colormap(bone)
caxis([0 2])
%clabel('# of FPs')
%title('number of stable solutions')
xlabel('\zeta (R/H_m_a_x)', 'FontSize',14)
ylabel('\Omega (M/r)', 'FontSize',14)
axis xy
set(gca,'YTick',[50,100,150,200])
set(gca,'YTickLabel',{'5','10','15','20'}, 'FontSize',14)
set(gca,'XTick',[20,40,60,80,100])
set(gca,'XTickLabel',{'0.2','0.4','0.6','0.8','1'}, 'FontSize',14)
axis square



