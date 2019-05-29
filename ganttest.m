function [] = ganttest(chrom,hangban,tingjiwei)

figure(2)
hangbannum = size(hangban,1);%航班数目
posNum = size(tingjiwei,1);%机位数目
axis([0,24,-1,posNum]);%x轴 y轴的范围
set(gca,'xtick',0:1:24) ;%x轴的增长幅度
set(gca,'ytick',0:1:posNum-1) ;%y轴的增长幅度
set(gcf,'position',[300,0,1000,4000]);
xlabel('时间'),ylabel('机位号');%x轴 y轴的名称
title('停机位分配（占用）甘特图');%图形的标题
%x轴 对应于画图位置的起始坐标x
n_start_time=zeros(1,hangbannum);
for i=1:hangbannum
    temp = hangban(i,2);
    n_start_time(i) = temp/60;
end
n_duration_time=zeros(1,hangbannum);
for i=1:hangbannum
    temp = hangban(i,3)- hangban(i,2);
    n_duration_time(i) = temp/60;
end


n_bay_start = chrom.Position;
rec=[0,0,0,0];%temp data space for every rectangle  
color=['r','g','b','c','m','y'];
for i =1:hangbannum  
  rec(1) = n_start_time(i);%矩形的横坐标
  rec(2) = n_bay_start(i)-0.35;  %矩形的纵坐标
  rec(3) = n_duration_time(i);  %矩形的x轴方向的长度
  rec(4) =0.7; 
  txt=sprintf('%d',hangban(i,1));
   rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',color(floor(rand*4+1)));%draw every rectangle  
   text(n_start_time(i)+0.05,(n_bay_start(i)+0.13),txt,'FontWeight','Bold','FontSize',8);%label the id of every task  ，字体的坐标和其它特性
end