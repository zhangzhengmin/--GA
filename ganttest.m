function [] = ganttest(chrom,hangban,tingjiwei)

figure(2)
hangbannum = size(hangban,1);%������Ŀ
posNum = size(tingjiwei,1);%��λ��Ŀ
axis([0,24,-1,posNum]);%x�� y��ķ�Χ
set(gca,'xtick',0:1:24) ;%x�����������
set(gca,'ytick',0:1:posNum-1) ;%y�����������
set(gcf,'position',[300,0,1000,4000]);
xlabel('ʱ��'),ylabel('��λ��');%x�� y�������
title('ͣ��λ���䣨ռ�ã�����ͼ');%ͼ�εı���
%x�� ��Ӧ�ڻ�ͼλ�õ���ʼ����x
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
  rec(1) = n_start_time(i);%���εĺ�����
  rec(2) = n_bay_start(i)-0.35;  %���ε�������
  rec(3) = n_duration_time(i);  %���ε�x�᷽��ĳ���
  rec(4) =0.7; 
  txt=sprintf('%d',hangban(i,1));
   rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',color(floor(rand*4+1)));%draw every rectangle  
   text(n_start_time(i)+0.05,(n_bay_start(i)+0.13),txt,'FontWeight','Bold','FontSize',8);%label the id of every task  ��������������������
end