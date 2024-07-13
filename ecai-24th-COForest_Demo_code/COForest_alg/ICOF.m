function [LctRec,ModeMtx] = ICOF(X,ModeMtx,K,NumVal,LctRec,Tree_DistMtx)
[Pm.Xlth,Pm.Xwd]=size(X); 
Pm.k=K;
Change=1;
Loop=0;
while Change==1 && Loop<=50 
    Change=0;
    Loop=Loop+1;
    cost_inner=zeros(1,Pm.Xlth);

    for i=1:Pm.Xlth
        DistVec=zeros(Pm.k,1);
        for j=1:Pm.k
            SubDist=zeros(1,Pm.Xwd);      
            for h=1:Pm.Xwd
                SubSubDist=zeros(1,NumVal(h)); 
                for m=1:NumVal(h)
                    if X(i,h)~=m
                        SubSubDist(m)=Tree_DistMtx{h}(X(i,h),m)*ModeMtx{j,h}(m); 
                    end
                end
                SubDist(h)=sum(SubSubDist)/(NumVal(h)-1); 
            end
            DistVec(j)=sum(SubDist)/Pm.Xwd;
        end
        [mindist,Winner]=min(DistVec);
        cost_inner(i)=mindist;
        if LctRec(i)~=Winner
            Change=1;
            LctRec(i)=Winner;
        end
    end
    for i=1:Pm.k 
        ClusterLth=length(find(LctRec==i));
        if sum(LctRec==i)>0
            for j=1:Pm.Xwd
                for h=1:NumVal(j)
                    ModeMtx{i,j}(h)=length(find(X(LctRec==i,j)==h))/ClusterLth;
                end
            end
        end
    end
 
end

