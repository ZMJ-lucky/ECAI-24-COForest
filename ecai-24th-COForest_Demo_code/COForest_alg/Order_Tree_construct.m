function MinTree_DistMtx=Order_Tree_construct(compete_graph)
    n = size(compete_graph, 1); 
    selected = false(1, n); 
    parent = zeros(1, n); 
    key = inf(1, n); 
    [~, start] = min(min(compete_graph));
    key(start) = 0;
    for i = 1:n
        u = minKey(key, selected);
        selected(u) = true;
        for v = 1:n
            if compete_graph(u, v) > 0 && ~selected(v) && compete_graph(u, v) < key(v)
                parent(v) = u;
                key(v) = compete_graph(u, v);
            end
        end
    end
 
    G = graph;
    G = addnode(G, n);
    for i = 1:n
        if parent(i)~=0
            G = addedge(G, parent(i), i, compete_graph(i, parent(i)));
        end
    end
    MinTree_DistMtx=zeros(n); %construct order-tree distmatrix
    for i=1:n
        for j=i+1:n
            [~,dist_minTree] = shortestpath(G, i, j);%Eq.()
            MinTree_DistMtx(i,j)=dist_minTree; 
            MinTree_DistMtx(j,i)=MinTree_DistMtx(i,j);
            
        end
    end
end

function u = minKey(key, selected)
    min_val = inf;
    u = -1;
    
    for i = 1:length(key)
        if ~selected(i) && key(i) < min_val
            min_val = key(i);
            u = i;
        end
    end
end


