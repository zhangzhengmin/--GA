function chroms = position(chroms,str,hangban,tingjiwei,inappropriated,timeInter)
%{
�� ��ȡ������Ϣ����λ��Ϣ��
�� ���ѡȡһ����λ����Ϊ�ú����ͣ��λ��ֱ����ͣ��λ�Ϸ���Ȼ
   ����¸û�λ�Ŀ��п�ʼʱ�䣬ʹ�û�λ�Ŀ��п�ʼʱ����ڸú������
   ��ʱ�䣻 
�� �Դ����ƣ�������н⡣��������ջ��к���δ���䣬�Ƶ�������
%}
disp('position executing...');
[~,n] = size(chroms);%n����Ⱥ��С
[~,m] = size(chroms{1,1}.HangbanSeNum);%m�Ǻ�����
[q,~] = size(tingjiwei);%q��ͣ��λ����

%���η����λ
if strcmp('first', str)
    i = 1;
    while i <= 2*n
        j = 1;
        while j<=m
                flag1 = 1;
                while flag1<=q
                     tt = randi([1 round(q)],1,1);%���ѡһ����λ
                %����ƥ�� 
                     if( (ismember(tingjiwei(tt,1),inappropriated(j,:)) ==0) &&  hangban(j,2)>=tingjiwei(tt,4))%�������ʱ��
                          chroms{1,i}.Position(j) =tingjiwei(tt,1);%����λ��
                          chroms{1,i}.HangbanSeNum = hangban(1:m, 1)';
                          chroms{1,i}.Fitness =zeros(1,1);
                          tingjiwei(tt,4) =hangban(j,3) + timeInter;   %����ͣ��λ�������ʱ��     
                          flag1=q;
                     end
                     flag1 = flag1+1;
                end
                j = j +1;
        end
        i = i+1;
        tingjiwei(:,4)=0;
    end
    %���桢���������Է���Լ��
elseif strcmp('else', str)
    i = 1;
    while i <= n
       point=0;
       j = 1;
       fulfil=[];
       unfulfil=[];
       
       %ͳ������Ҫ���벻����Ҫ��ĺ��༯�ϣ����ȫ������Ҫ����������ѭ��
       while j <= m
            %ͳ�ƺ�������Ҫ���벻����Ҫ��ļ���,��¼�����ж����Ǿ���ĺ���
            if(ismember( chroms{1,i}.Position(j),inappropriated(j,:)) ==0 &&  hangban(j,2)>=tingjiwei( chroms{1,i}.Position(j)+1,4) )
                tingjiwei((chroms{1,i}.Position(j))+1,4) =hangban(j,3) + timeInter;%���»�λ����ʱ��
                fulfil=[fulfil j];
                j=j+1;
            else
                unfulfil=[unfulfil j];
                j=j+1;
            end      
       end
       
       %����ø�����û�в�����Ҫ��ĺ��࣬���������е���������
       if isempty(unfulfil)==1
           i=i+1;
           point=1;
           continue;
       end
       %�����в�����Ҫ��ĺ���������·���
       flag=1;
       while  flag<=5
         un_fulfil=unfulfil;
         ful_fil=fulfil;
         %��������
         for p = un_fulfil
              %�Բ�����Ҫ��ĺ���ͳ�ƿ���ѡ��Ŀ��л�λ
               onuseHB = zeros(1,q);  
               notonuse=[];
               for t=ful_fil
                   if (hangban(t,2)-timeInter<hangban(p,3) || hangban(t,3)+timeInter>hangban(p,2) )
                       onuseHB(1,chroms{1,i}.Position(t)+1) = 1;
                   end
               end
              %�γɺ���p�Ŀ��û�λ����onuseB 
               notonuse=find(onuseHB==0);
               %���ѡ��һ�����û�λ 
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
       %����������ɴ�������Ϊ�����н⣬�򽫴˽��϶�Ϊ�Ͻ⣬���ø������ÿ�
       if point==0
           chroms{1,i}.Position=[];
       end
       i = i+1;
       tingjiwei(:,4)=0;
    end
end 
end
