

function [ modes , partition_new] = initialize( X ,Pm ,NumVal)

modes( 1 , : ) = X( randperm( Pm.Xlth , 1 ) , 1 : Pm.Xwd );
no_initial_mode = 1;
while no_initial_mode ~= Pm.k
    no_initial_mode = no_initial_mode + 1;
    modes( no_initial_mode , : ) = X( randperm( Pm.Xlth , 1 ) , 1 : Pm.Xwd );
    if sum ( sum( modes == modes( no_initial_mode , : ) , 2 ) == Pm.Xwd ) ~= 1
        no_initial_mode = no_initial_mode - 1;
    end
end
dis_matrix = cell( 1 , Pm.Xwd );
for i=1:Pm.Xwd 
    sub_dissim_matrix_upper = triu( ones( NumVal(i) ) , 1); %
    dis_matrix{ i } = sub_dissim_matrix_upper + sub_dissim_matrix_upper'; %
end

loop_stop = 0;
no_loop=0;
partition_old = zeros( Pm.Xlth , 1 );
while loop_stop == 0 && no_loop<=50
    partition_new = zeros( Pm.Xlth , 1 );
    no_loop = no_loop + 1;
    dis_obj_modes = zeros( Pm.Xlth , Pm.k );
    for i=1:Pm.Xlth
        for j=1:Pm.k
            dis_sub = zeros( 1 , Pm.Xwd );
            for t = 1 : Pm.Xwd
                dis_sub( t ) = dis_matrix{ t }( X( i , t ) , modes( j , t ) ) ;
            end
            dis_obj_modes( i , j ) = mean( dis_sub );
           
        end
        [ ~ , partition_new( i ) ] = min( dis_obj_modes( i , : ) );
    end
  
    if sum( sum( abs( partition_new - partition_old ) ) ) == 0
        loop_stop = 1;
    end
    partition_old = partition_new;
    for j = 1 : Pm.k
        x_sub = X( partition_new == j , 1 : Pm.Xwd );
        if isempty( x_sub ) == 0
            for t = 1 : Pm.Xwd
                sta_table = tabulate( x_sub( : , t ) );
                [ ~ , lct_max_freq ]= max( sta_table( : , 2 ) );
                modes( j , t )= sta_table( lct_max_freq , 1 );
            end
        end
    end
end

end
