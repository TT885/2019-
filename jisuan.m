rang=40;
A=zeros(rang,rang);
xi=zeros(rang);
xi(1)=0.25;xi(2)=0.5;xi(3)=0.1875;xi(4)=0.0625;
A(1,1)=1;
% A(2,1)=0.25;A(2,2)=0.5;A(2,3)=0.1875;A(2,4)=0.0625;
for i =1:rang-1
    for j=0:rang-1
        for k= 0:j
            A(i+1,j+1)=A(i+1,j+1)+xi(k+1)*A(i,j-k+1);
        end
    end
end
[X,Y] = meshgrid(1:size(A,1),1:size(A,2));
a=figure;
mesh(X,Y,A)
%set(gca,'ZScale','log');
xlabel("iÖá");
ylabel("jÖá");
zlabel("a_{i,j}");
zlim([0,0.3]);
title([num2str(rang)+"\times"+num2str(rang)+"×´Ì¬×ªÒÆ¾ØÕó"]);
saveas(a,"matrix.jpg");
for i =1:10
    fprintf("%f",A(i,1))
    for j=2:10
        fprintf("&%.4f",A(i,j))
    end
    fprintf("\\\\\n");
end
