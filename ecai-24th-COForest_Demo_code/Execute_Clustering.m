
clear;
clc;
T=10; % set 10 runs of the experiment
%% Clustering for Caesarian Section
load CS;
X=CS;
CA=zeros(T,1);
ARI=zeros(T,1);
NMI=zeros(T,1);
CPS=zeros(T,1);
NCC=zeros(T,1);
[Pm.Xlth,Pm.Xwd]=size(X);
XLable=X(:,Pm.Xwd);
Pm.Xwd=Pm.Xwd-1;
Pm.Owd=Pm.Xwd;
Pm.k=max(XLable);
Modes=zeros(Pm.k,Pm.Xwd);
for t=1:T
    Modes( 1 , : ) = X( randperm( Pm.Xlth , 1 ) , 1 : Pm.Xwd );
    no_initial_mode = 1;
    while no_initial_mode ~= Pm.k
        no_initial_mode = no_initial_mode + 1;
        Modes( no_initial_mode , : ) = X( randperm( Pm.Xlth , 1 ) , 1 : Pm.Xwd );
        if sum ( sum( Modes == Modes( no_initial_mode , : ) , 2 ) == Pm.Xwd ) ~= 1
            no_initial_mode = no_initial_mode - 1;
        end
    end
    [CA(t),ARI(t),NMI(t)] = COForest_main(X,Modes);
end

disp('clustering performance on CS data set:');
AccMean=mean(CA);
ARIMean=mean(ARI);
NMIMean=mean(NMI);
AccMean
ARIMean
NMIMean

%% Clustering for HF
load HF;
X=HF_c;
CA=zeros(T,1);
ARI=zeros(T,1);
NMI=zeros(T,1);
CPS=zeros(T,1);
NCC=zeros(T,1);
[Pm.Xlth,Pm.Xwd]=size(X);
XLable=X(:,Pm.Xwd);
Pm.Xwd=Pm.Xwd-1;
Pm.Owd=Pm.Xwd;
Pm.k=max(XLable);
Modes=zeros(Pm.k,Pm.Xwd);
for t=1:T
    Modes( 1 , : ) = X( randperm( Pm.Xlth , 1 ) , 1 : Pm.Xwd );
    no_initial_mode = 1;
    while no_initial_mode ~= Pm.k
        no_initial_mode = no_initial_mode + 1;
        Modes( no_initial_mode , : ) = X( randperm( Pm.Xlth , 1 ) , 1 : Pm.Xwd );
        if sum ( sum( Modes == Modes( no_initial_mode , : ) , 2 ) == Pm.Xwd ) ~= 1
            no_initial_mode = no_initial_mode - 1;
        end
    end
    [CA(t),ARI(t),NMI(t)] = COForest_main(X,Modes);
end

disp('clustering performance on HF data set:');
AccMean=mean(CA);
ARIMean=mean(ARI);
NMIMean=mean(NMI);
AccMean
ARIMean
NMIMean






