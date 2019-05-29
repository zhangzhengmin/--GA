function chroms = sortByFitness(chroms)
%{
���غ�������Ӧ��ֵ����
�״β����뾫Ӣ
֮���þ�Ӣ�滻�������������
%}

if nargin==1
    [~,n] = size(chroms);
    for i = n:-1:1
     %ÿһ���ɵ����ϵ�����
         for j = 1:1:i-1
               if chroms{1,j+1}.Fitness > chroms{1,j}.Fitness
                   temp = chroms{1,j};
                   chroms{1,j} = chroms{1,j+1};
                   chroms{1,j+1} = temp;
               end
         end
    end
    
elseif  nargin==2
    chroms = varargin{1};
    [~,n] = size(chroms);
    chromBest = varargin{2};
    goal = varargin{3};
    chroms = sortByFitness(chroms,goal);
    chroms{1,n} = chromBest;
    chroms = sortByFitness(chroms,goal);
end
end
