function chroms = fitness(chroms, tingjiwei)
disp('fitness executing...');
%����λ�������
[~,n] = size(chroms);
[~,m] = size(chroms{1,1}.HangbanSeNum);
chromsIndex = 1;
while chromsIndex<=n
    HangbanIndex = 1;
    kaoqiaohbNum = 0;
    while HangbanIndex<=m     
          Pos = chroms{1,chromsIndex}.Position(HangbanIndex); 
          if tingjiwei(Pos+1,3)==1%������ʵ�ʻ�λ����һ
               kaoqiaohbNum = kaoqiaohbNum + 1; 
          end
          HangbanIndex=HangbanIndex + 1;
    end
    
   %������
    chroms{1,chromsIndex}.Fitness = kaoqiaohbNum;
    chromsIndex = chromsIndex + 1;
end
end