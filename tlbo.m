function dfs = tlbo(f,N,D,G,img,templ) 

[img_H,img_W] = size(img);
[temp_H,temp_W] = size(templ);

x1 = [1; 1];
xu = [(img_H-temp_H);(img_W-temp_W)];

x = zeros(D,N); %definicion de la poblacion
c = zeros(D,1);
fitness = zeros(1,N);

for i=1:N
    x(:,i) = x1+(xu-x1).*rand(D,1);
    x(1,i) = round(x(1,i));
    x(2,i) = round(x(2,i));
    while((x(1,i) < 1 || x(1,i) > xu(1)) || ((x(2,i) < 1 || x(2,i) > xu(2))))
        x(:,i) = x1+(xu-x1).*rand(D,1);
        x(1,i) = round(x(1,i));
        x(2,i) = round(x(2,i));
    end
    fitness(i) = f(x(2,i),x(1,i),img,templ);
end

for i=1:G
    for j=1:N
        
        %fase de enseñanza
       [~,igb] = min(fitness);
       Tf = randi(2);
       
       for z=1:D
           
        xPro = 0.0;
        for o=1:N
            xPro = xPro + x(z,o); 
        end
        xPro = xPro * (1 / N);
        r = rand();

               
        c(z,1) = x(z,j) + (r*(x(z,igb))) - (Tf * xPro);
           
       end
       
       c(1,1) = round(c(1,1));
       c(2,1) = round(c(2,1));
       while((c(1,1) < 1 || c(1,1) > xu(1)) || ((c(2,1) < 1 || c(2,1) > xu(2))))
           c(:,1) = x1+(xu-x1).*rand(D,1);
           c(1,1) = round(c(1,1));
           c(2,1) = round(c(2,1));
       end
       

       fx = f(c(2,1),c(1,1),img,templ);
       if(fx > fitness(j))
        fitness(j) = fx;
        x(:,j) = c;
       end
        
       %fase de aprendizaje
       k = randi(N);
        while(k == j)
           k = randi(N);
        end
        
        if(fitness(j) > fitness(k))
        for z=1:D
            
            r = rand();
            c(z,1) = x(z,j) + (r*(x(z,j) - x(z,k)));
           
        end
        else
        for z=1:D
            
            r = rand();
            c(z,1) = x(z,j) + (r*(x(z,k) - x(z,j)));
           
        end
        end
        
       c(1,1) = round(c(1,1));
       c(2,1) = round(c(2,1));
       while((c(1,1) < 1 || c(1,1) > xu(1)) || ((c(2,1) < 1 || c(2,1) > xu(2))))
           c(:,1) = x1+(xu-x1).*rand(D,1);
           c(1,1) = round(c(1,1));
           c(2,1) = round(c(2,1));
       end
       
        
       fx = f(c(2,1), c(1,1),img,templ);
       if(fx > fitness(j))
        fitness(j) = fx;
        x(:,j) = c;
       end
       
       
    end
    
end

disp(fitness(igb));
disp(x);

dfs = x(:,1);
end