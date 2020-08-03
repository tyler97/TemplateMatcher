function dfs = diferencial(f,N,D,G,Cr,F,img,templ) 


[img_H,img_W] = size(img);
[temp_H,temp_W] = size(templ);

x1 = [1; 1];
xu = [(img_H-temp_H);(img_W-temp_W)];

disp(xu);

x = zeros(D,N); %definicion de la poblacion
v = zeros(D,N); %definicion de las mutaciones
u = zeros(D,N); %Vector de prueba

for i=1:N
    x(:,i) = x1+(xu-x1).*rand(D,1);
    x(1,i) = round(x(1,i));
    x(2,i) = round(x(2,i));
    while((x(1,i) < 1 || x(1,i) > xu(1)) || ((x(2,i) < 1 || x(2,i) > xu(2))))
        x(:,i) = x1+(xu-x1).*rand(D,1);
        x(1,i) = round(x(1,i));
        x(2,i) = round(x(2,i));
    end
    
end

disp(x);

for i=1:G
    for j=1:N
        
        r1 = randi(N);
        r2 = randi(N);
        r3 = randi(N);
        
        while(r1 ~= r2 && r1 ~= r3 && r2 ~= r3 && r1 ~= j && r2 ~= j && r3 ~= j)
                    r1 = randi(N);
                    r2 = randi(N);
                    r3 = randi(N);
        end
        
        v(:,j) = x(:,r1) + (F * (x(:,r2) - x(:,r3)));

        v(1,j) = round(v(1,j));
        v(2,j) = round(v(2,j));
        while((v(1,j) < 1 || v(1,j) > xu(1)) || ((v(2,j) < 1 || v(2,j) > xu(2))))
            v(:,j) = x1+(xu-x1).*rand(D,1);
            v(1,j) = round(v(1,j));
            v(2,j) = round(v(2,j));
        end
        
        
        for k=1:D
            if rand() <= Cr
                u(k,j) = v(k,j);
            else
                u(k,j) = x(k,j);
            end
                
        end
        
        if(f(u(2,j) ,u(1,j),img,templ) > f(x(2,j),x(1,j),img,templ))
            x(:,j) = u(:,j);
        end
        
    end
    
end

disp(x);
dfs = x(:,1);
end