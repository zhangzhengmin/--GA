function chroms1 = selection(chroms)
%Ñ¡Ôñ
disp('selection executing...');
[~,n] = size(chroms);

fit =0;
fitPos = zeros(1,n);
fitnessEl=0;
fitnessSum = 0;
chroms1 = chroms;

for i=1:n
      fit= chroms{1,i}.Fitness;
      fitnessSum = fitnessSum + fit;
end

for i=1:n
      fit = chroms{1,i}.Fitness;
      fitnessEl = fitnessEl + fit;
      fitPos(1,i) =  fitnessEl/fitnessSum;
end

index =1;
while index<=n
    r=rand;
    for i=1:n
        if r<fitPos(1,i)
            chroms1{1,index}=chroms{1,i};  
        break;
        end    
    end
    index = index + 1;
end
end




