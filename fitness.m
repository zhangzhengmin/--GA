function chroms = fitness(chroms, tingjiwei)
disp('fitness executing...');
%近机位航班最多
[~,n] = size(chroms);
[~,m] = size(chroms{1,1}.HangbanSeNum);
chromsIndex = 1;
while chromsIndex<=n
    HangbanIndex = 1;
    kaoqiaohbNum = 0;
    while HangbanIndex<=m     
          Pos = chroms{1,chromsIndex}.Position(HangbanIndex); 
          if tingjiwei(Pos+1,3)==1%行数比实际机位数多一
               kaoqiaohbNum = kaoqiaohbNum + 1; 
          end
          HangbanIndex=HangbanIndex + 1;
    end
    
   %近机率
    chroms{1,chromsIndex}.Fitness = kaoqiaohbNum;
    chromsIndex = chromsIndex + 1;
end
end