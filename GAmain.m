clc
clear
%数据导入
load 航班
load 停机位

%{
一，航班信息
列
1：  航班号
2：  到达时间
3：  起飞时间

二，停机位信息
列
1：机位号
2：间隔时间
3：是否近机位（11是 0否 ）
4-10:不适配机位
%}

hangban = sortrows(hangban,2);
%不适配机位
inappropriated=hangban(:,4:10);
[m,~]=size(hangban);
%相邻两航班之间的最小安全时间间隔(min)
timeInter = 30;

%解结构，参数设定 =======================================
config = load('config.txt');
%最大迭代次数
Maxgen = config(1,1);
%种群大小
Y = config(1,2);
%交叉算子
croPos = config(1,3);
%变异算子
mutPos = config(1,4);
%一次迭代解集
chroms = cell(1,Y);

%计时开始
tic;

%初始化，构建初始方案/种群
for i=1:Y
    structchroms.HangbanSeNum = hangban(1:m, 1)';
    structchroms.Position = zeros(1,m);
    structchroms.Fitness =zeros(1,1);
    chroms{1,i} = structchroms;
end

disp('分配机位');
%分配机位
chroms = position(chroms,'first',hangban,tingjiwei,inappropriated,timeInter);
%计算适应度
chroms = fitness(chroms,tingjiwei);
%适应度值排序
chroms = sortByFitness(chroms);
chroms =chroms(1:Y);
%每代精英策略
chromBest = chroms{1,1};
%历史记录
trace=zeros(1,Maxgen);
disp('迭代开始');
%迭代开始
k=1;


while(k<=Maxgen)
    fprintf('%s%d\n','进化代数',k);
    %选择
    chroms = selection(chroms);
    %交叉
    chroms = crossover(chroms, croPos);
    %变异
    chroms = mutation(chroms, tingjiwei, mutPos);
    %计算fitness
    chroms = position(chroms,'else',hangban,tingjiwei,inappropriated,timeInter);

    %将不可行解替换成当前最优解，加快收敛
    i=1;
    while i<=Y
        if isempty(chroms{1,i}.Position)==1
           chroms{1,i}.Position=chromBest.Position;
        end
        i=i+1;
    end
   
    chroms = fitness(chroms, tingjiwei);
    %适应度值排序
    chroms = sortByFitness(chroms);
    %统计，取出精英
    chromBest = chroms{1,1}; 
    trace(1,k) = chroms{1,1}.Fitness;
    k = k + 1;
    %迭代结束
end
%计时结束
toc;

%输出最优个体行  1：航班序列号  2：机位号  3:适应度值
disp(toc)
disp('航班序列号');
chroms{1,1}.HangbanSeNum
disp('机位号');
chroms{1,1}.Position
disp('单目标：近机位数量最大化');
chroms{1,1}.Fitness
 
%画出迭代图目标标函数
figure(1)
plot(trace(1,:))
hold on, grid;
xlabel('进化代数');
ylabel('最优解变化');
title('单目标问题：近机位数量最大化')

%甘特图
ganttest(chroms{1,1},hangban,tingjiwei);








