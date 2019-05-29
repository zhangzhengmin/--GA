function chroms = position(chroms,str,hangban,tingjiwei,inappropriated,timeInter)
%{
① 读取航班信息，机位信息；
② 随机选取一个机位，作为该航班的停机位，直到该停机位合法，然
   后更新该机位的空闲开始时间，使该机位的空闲开始时间等于该航班的离
   港时间； 
③ 以此类推，输出可行解。（如果最终还有航班未分配，推倒重来）
%}
disp('position executing...');
[~,n] = size(chroms);%n是种群大小
[~,m] = size(chroms{1,1}.HangbanSeNum);%m是航班数
[q,~] = size(tingjiwei);%q是停机位个数

%初次分配机位
if strcmp('first', str)
    i = 1;
    while i <= 2*n
        j = 1;
        while j<=m
                flag1 = 1;
                while flag1<=q
                     tt = randi([1 round(q)],1,1);%随机选一个机位
                %机型匹配 
                     if( (ismember(tingjiwei(tt,1),inappropriated(j,:)) ==0) &&  hangban(j,2)>=tingjiwei(tt,4))%最早空闲时间
                          chroms{1,i}.Position(j) =tingjiwei(tt,1);%更新位置
                          chroms{1,i}.HangbanSeNum = hangban(1:m, 1)';
                          chroms{1,i}.Fitness =zeros(1,1);
                          tingjiwei(tt,4) =hangban(j,3) + timeInter;   %更新停机位最早空闲时间     
                          flag1=q;
                     end
                     flag1 = flag1+1;
                end
                j = j +1;
        end
        i = i+1;
        tingjiwei(:,4)=0;
    end
    %交叉、变异后调整以符合约束
elseif strcmp('else', str)
    i = 1;
    while i <= n
       point=0;
       j = 1;
       fulfil=[];
       unfulfil=[];
       
       %统计满足要求与不满足要求的航班集合，如果全部满足要求，则跳过本循环
       while j <= m
            %统计航班满足要求与不满足要求的集合,记录的是列而不是具体的航班
            if(ismember( chroms{1,i}.Position(j),inappropriated(j,:)) ==0 &&  hangban(j,2)>=tingjiwei( chroms{1,i}.Position(j)+1,4) )
                tingjiwei((chroms{1,i}.Position(j))+1,4) =hangban(j,3) + timeInter;%更新机位空闲时间
                fulfil=[fulfil j];
                j=j+1;
            else
                unfulfil=[unfulfil j];
                j=j+1;
            end      
       end
       
       %如果该个体中没有不满足要求的航班，则跳过下列的修正过程
       if isempty(unfulfil)==1
           i=i+1;
           point=1;
           continue;
       end
       %对所有不满足要求的航班进行重新分配
       flag=1;
       while  flag<=5
         un_fulfil=unfulfil;
         ful_fil=fulfil;
         %修正过程
         for p = un_fulfil
              %对不满足要求的航班统计可以选择的空闲机位
               onuseHB = zeros(1,q);  
               notonuse=[];
               for t=ful_fil
                   if (hangban(t,2)-timeInter<hangban(p,3) || hangban(t,3)+timeInter>hangban(p,2) )
                       onuseHB(1,chroms{1,i}.Position(t)+1) = 1;
                   end
               end
              %形成航班p的可用机位序列onuseB 
               notonuse=find(onuseHB==0);
               %随机选择一个可用机位 
               b=length(notonuse);
               if b==0
                   break;
               else
                  a=randi([1 b],1,1);
                  chroms{1,i}.Position(p)=tingjiwei(notonuse(a),1);
                  ful_fil=[ful_fil p];  
               end
         end   
         if length(ful_fil)==m
             point=1;
             flag=5;
         end
         flag=flag+1;
       end
       %如果经历若干次修正仍为不可行解，则将此解认定为废解，将该个体结果置空
       if point==0
           chroms{1,i}.Position=[];
       end
       i = i+1;
       tingjiwei(:,4)=0;
    end
end 
end
