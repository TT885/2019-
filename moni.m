% x=normrnd(0,1,[1,100000000]);
% a=hist(x,1000);
% disp(sum(a(1:500)/sum(a)));
% plot(a)

res=zeros(1,20);
EA=zeros(1,20);
s=zeros(1,20);
rounds=1000000;
turns=1000;
y=zeros(1,rounds);
EX=linspace(1,1000,1000);
EX(1000)=0;
for r= 1:20
    for i =1:rounds
        x=r;
        for j=1:turns
            xx=0;
            for k=1:x
                p=rand;
                %p=unifrnd(0,1);
                if p<0.25
                    ;
                elseif p<0.75
                    xx=xx+1;
                elseif p<0.9375
                    xx=xx+2;
                else
                    xx=xx+3;
                end     
            end
            x=xx;
            if x==0
                y(i)=j;
                break;
            elseif x>100
                y(i)=turns;
                break;
            end
        end
    end
    a=hist(y,turns)/rounds;
    res(r)=1-a(turns);
    disp(['k=',num2str(r),"灭绝概率:",num2str(1-a(turns))])
    EA(r)=EX*a';
    [m,s(r)]=max(a(1:999));
    fig1=figure;
    plot(a(1:50));
    title(["k="+num2str(r)+"灭绝时间概率分布图("+num2str(rounds)+"次模拟结果)"]);
    text(sum(xlim)*0.6,sum(ylim)*0.6,["生存到"+num2str(turns)+"轮的概率为"+num2str(a(turns))+char(10)+"认为灭绝概率即为"+num2str(1-a(turns))])
    text(s(r),m*0.9,["最概然灭绝时间"+num2str(s(r))+",灭绝概率"+num2str(m)]);
    text(sum(xlim)*0.5,sum(ylim)*0.5,["灭绝种群的平均灭绝时间"+num2str(EA(r))])
    xlabel('轮次n')
    ylabel('灭绝概率P(n)')
    saveas(fig1,"k="+num2str(r)+"灭绝时间概率分布图.jpg");
end
figres=figure;
x=linspace(1,20,20);
plot(x,0.828.^x);
title('灭绝概率与初始种群容量理论曲线与实验数据','FontSize',20)
xlabel('初始个体数X_0','FontSize',14);
ylabel('灭绝概率\pi_{X_0}','Fontsize',14);
hold on
scatter(x,res,'*');
text(sum(xlim)*0.1,sum(ylim)*0.6,["蓝色曲线为理论曲线\pi_k=\pi_1^k"+char(10)+"红色*为随机模拟结果"+char(10)+"两者在小数点后四位完全符合"],'FontSize',24);
saveas(figres,"灭绝概率与初始种群容量理论曲线与实验数据.jpg");
figp=figure;
plot(x,s,'--p');
hold on;
plot(x,EA,'+k');
[yy,xx]=max(EA);
legend('最概然灭绝时间','平均灭绝时间','Location','northwest');
title('最概然灭绝时间和平均灭绝时间','FontSize',24);
text(xx-3,yy*1.2,["最大平均灭绝时间"+num2str(yy)+char(10)+"当X_0="+num2str(xx)+"时取得"],'FontSize',24);
xlabel('初始个体数X_0','FontSize',14);
ylabel('灭绝时间','FontSize',14);
saveas(figp,"最概然灭绝时间和平均灭绝时间.jpg");
