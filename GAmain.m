clc
clear
%���ݵ���
load ����
load ͣ��λ

%{
һ��������Ϣ
��
1��  �����
2��  ����ʱ��
3��  ���ʱ��

����ͣ��λ��Ϣ
��
1����λ��
2�����ʱ��
3���Ƿ����λ��11�� 0�� ��
4-10:�������λ
%}

hangban = sortrows(hangban,2);
%�������λ
inappropriated=hangban(:,4:10);
[m,~]=size(hangban);
%����������֮�����С��ȫʱ����(min)
timeInter = 30;

%��ṹ�������趨 =======================================
config = load('config.txt');
%����������
Maxgen = config(1,1);
%��Ⱥ��С
Y = config(1,2);
%��������
croPos = config(1,3);
%��������
mutPos = config(1,4);
%һ�ε����⼯
chroms = cell(1,Y);

%��ʱ��ʼ
tic;

%��ʼ����������ʼ����/��Ⱥ
for i=1:Y
    structchroms.HangbanSeNum = hangban(1:m, 1)';
    structchroms.Position = zeros(1,m);
    structchroms.Fitness =zeros(1,1);
    chroms{1,i} = structchroms;
end

disp('�����λ');
%�����λ
chroms = position(chroms,'first',hangban,tingjiwei,inappropriated,timeInter);
%������Ӧ��
chroms = fitness(chroms,tingjiwei);
%��Ӧ��ֵ����
chroms = sortByFitness(chroms);
chroms =chroms(1:Y);
%ÿ����Ӣ����
chromBest = chroms{1,1};
%��ʷ��¼
trace=zeros(1,Maxgen);
disp('������ʼ');
%������ʼ
k=1;


while(k<=Maxgen)
    fprintf('%s%d\n','��������',k);
    %ѡ��
    chroms = selection(chroms);
    %����
    chroms = crossover(chroms, croPos);
    %����
    chroms = mutation(chroms, tingjiwei, mutPos);
    %����fitness
    chroms = position(chroms,'else',hangban,tingjiwei,inappropriated,timeInter);

    %�������н��滻�ɵ�ǰ���Ž⣬�ӿ�����
    i=1;
    while i<=Y
        if isempty(chroms{1,i}.Position)==1
           chroms{1,i}.Position=chromBest.Position;
        end
        i=i+1;
    end
   
    chroms = fitness(chroms, tingjiwei);
    %��Ӧ��ֵ����
    chroms = sortByFitness(chroms);
    %ͳ�ƣ�ȡ����Ӣ
    chromBest = chroms{1,1}; 
    trace(1,k) = chroms{1,1}.Fitness;
    k = k + 1;
    %��������
end
%��ʱ����
toc;

%������Ÿ�����  1���������к�  2����λ��  3:��Ӧ��ֵ
disp(toc)
disp('�������к�');
chroms{1,1}.HangbanSeNum
disp('��λ��');
chroms{1,1}.Position
disp('��Ŀ�꣺����λ�������');
chroms{1,1}.Fitness
 
%��������ͼĿ��꺯��
figure(1)
plot(trace(1,:))
hold on, grid;
xlabel('��������');
ylabel('���Ž�仯');
title('��Ŀ�����⣺����λ�������')

%����ͼ
ganttest(chroms{1,1},hangban,tingjiwei);








