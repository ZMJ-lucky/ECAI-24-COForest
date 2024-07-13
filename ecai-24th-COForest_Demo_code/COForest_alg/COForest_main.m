 
% TOCL 
function [ACC,ARI,NMI]= COForest_main(X,~)
[Pm.Xlth,Pm.Xwd]=size(X); % fetch the statistics of data set
XLable=(X(:,Pm.Xwd));
Pm.Xwd=Pm.Xwd-1;
X=X(:,1:Pm.Xwd);
Pm.k=max(XLable);
NumVal=zeros(1,Pm.Xwd);
Val_list=cell(1,Pm.Xwd); 
Val_count=cell(1,Pm.Xwd);
for i=1:Pm.Xwd
    nvi=length(unique(X(:,i)));
    NumVal(i)=nvi;
    count_list=zeros(1,nvi);
    for c=1:nvi
        count_list(c)=length(find(X(:,i)==c));
    end
    Val_list{i}=1:nvi;
    Val_count{i}=count_list;%记录每个value中出现的频次
end
[~,LctRecFOld]=initialize(X,Pm,NumVal);
% initialized ModeMtx
ModeMtx=cell(Pm.k,Pm.Xwd); % form k cluster descriptors according to the initialized k modes
for i=1:Pm.k % update ModeMtx for the next loop
    ClusterLth=length(find(LctRecFOld==i));
    if sum(LctRecFOld==i)>0
        for j=1:Pm.Xwd
            for h=1:NumVal(j)
                ModeMtx{i,j}(h)=length(find(X(LctRecFOld==i,j)==h))/ClusterLth;
            end
        end
    end
end
%initialized order forest
Tree_DistMtx=TreeStruct_DistMtx(ModeMtx,LctRecFOld,Val_list,NumVal,X,Pm,Val_count);
LctRecC=zeros(Pm.Xlth,1); 
FChange=1; 
LoopD=0;
while FChange==1 && LoopD<=50 
    LoopD=LoopD+1;
    [LctRecC,ModeMtx]=ICOF(X,ModeMtx,Pm.k,NumVal,LctRecC,Tree_DistMtx); 
    if  sum(LctRecFOld-LctRecC)==0 
        FChange=0;
    else 
        LctRecFOld=LctRecC; 
        Tree_DistMtx=TreeStruct_DistMtx(ModeMtx,LctRecFOld,Val_list,NumVal,X,Pm,Val_count);
    end      
end
ACC=Eva_CA(LctRecC,XLable); % CA evaluation
ARI=Eva_ARI(LctRecC, XLable, 'adjusted'); % ARI evaluation
NMI=Eva_NMI(XLable, LctRecC); % NMI evaluation

end


