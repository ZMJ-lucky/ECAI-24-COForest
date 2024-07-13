function [Tree_DistMtx,Tree_struct]=TreeStruct_DistMtx(ModeMtx,LctRecFOld,~,NumVal,~,Pm,Val_count)
        Tree_DistMtx=cell(1,Pm.Xwd);  % initialize the distance weights 
        Tree_struct=cell(1,Pm.Xwd);      
        cluster_len_list=zeros(1,Pm.k);
        for j=1:Pm.k
            ClusterLth=length(find(LctRecFOld==j));
            cluster_len_list(j)=ClusterLth;
        end
        for col=1:Pm.Xwd
            p_k=zeros(NumVal(col),Pm.k);
            for k=1:Pm.k
                p_kv=transpose((ModeMtx{k,col}.*cluster_len_list(k))./Val_count{col}); 
%                 disp(p_kv)
                p_k(:,k)=p_kv;
%                 disp(p_k)
            
            end
            DistMtx=inf(NumVal(col));
            for v1=1:NumVal(col)
                for v2=v1+1:NumVal(col)
                    DistMtx(v1,v2)=pdist2(p_k(v1,:),p_k(v2,:))*(1/Pm.k); %归一化
%                     disp(pdist2(p_k(v1,:),p_k(v2,:)));
%                     pause
                    DistMtx(v2,v1)=DistMtx(v1,v2);
                end
            end
            
%             disp(DistMtx);
            DistMtx(DistMtx==0)=0.00000001;
            A_TreeDistMtx=Order_Tree_construct(DistMtx);
            Tree_DistMtx{col}=A_TreeDistMtx;

        end
end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
%         %计算树结构下的距离矩阵
%         Tree_DistMtx=cell(1,Pm.Xwd);  % initialize the distance weights 
%         Tree_struct=cell(1,Pm.Xwd);      
%         node_importance_list=cell(1,Pm.Xwd);%记录每列中value的重要性
%         for col =1:Pm.Xwd
%             entropy_col_list=zeros(1,NumVal(col));
%             for k=1:Pm.k
%               %log不能操作0或者负数
%              
%               element = (ModeMtx{k,col}.*cluster_len_list(k))./Val_count{col}; 
%                
%               entro_add=-element .* log2(element);
%               entro_add(isnan(entro_add))=0;%将log0的nan值设为0
%               entropy_col_list = entropy_col_list + entro_add; 
%               %记录每列中value熵值        
%             end
% %             entropy_col_list=((1/log(Pm.k)) .*entropy_col_list);%熵值正则化
%             node_importance_list{col}=entropy_col_list; %每列节点的重要性
%             DistMtx=inf(NumVal(col));
%             for v1=1:NumVal(col)
%                 for v2=v1+1:NumVal(col)
%                     %防止element=1的情况
%                     if entropy_col_list(v1)==0 
%                         entropy_col_list(v1)=0.0000001;
%                     end
%                     if entropy_col_list(v2)==0 
%                         entropy_col_list(v2)=0.0000001;
%                     end
%                     DistMtx(v1,v2)=(entropy_col_list(v1)+entropy_col_list(v2))/sum(entropy_col_list); %归一化
%                     DistMtx(v2,v1)=DistMtx(v1,v2);
%                 end
%             end
%             
%         end
% end