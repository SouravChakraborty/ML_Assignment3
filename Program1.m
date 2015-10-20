load('iris.dat.mat');
% Descritizing the dataset
Desc_Mat=floor(Data+1);
Desc_Mat(:,5)=Desc_Mat(:,5)-1;

[row column]=size(Desc_Mat);

% partitioning the data as Training and Testing data
randIdx=randperm(row);
trainIdx=randIdx(1,1:100);
testIdx=randIdx(1,100:150);

TrainData=Desc_Mat(trainIdx,:);
TestData=Desc_Mat(testIdx,:);

% % % % % % % % % % % Find-S alogirthm  % % % % % % % % % % % % % % % %  % % % % % %

[h]=findsAlgorithm(TrainData);
%     Output hypothesis from the Find-S Alogirthm is
fprintf('Output hypothesis from the Find-S Alogirthm\n')
disp(h);

% % % % % % % % % % % List then Eliminate alogirthm  % % % % % % % % % % % % % % % %  % % % % % %


[VS]=ListE(Desc_Mat,TrainData)
fprintf('\n VersionSpace that is consistent with the training data is \n');
disp(VS);


% % % % % % % % % % % Candidate alogirthm  % % % % % % % % % % % % % % % %  % % % % % %
S=[nan,nan,nan,nan];
G=[-1,-1,-1,-1];

for index=1:length(TrainData)
    
    if(TrainData(index,5)==1)
        if(sum(isnan(S))==4)
            S(1,:)=TrainData(index,1:4);
        end
%        Removing inconsistencies from G
            [G]=removeInconsistentRows(G,TrainData(index,:))
        
%         Values 
        if(S(1,1)~=TrainData(index,1) && S(1,1)~=-1)
            S(1,1)=-1;
        end
        if (S(1,2)~=TrainData(index,2) && S(1,2)~=-1)
            S(1,2)=-1;
        end
        if (S(1,3)~=TrainData(index,3) && S(1,3)~=-1)
            S(1,3)=-1;
        end
        
        if (S(1,4)~= TrainData(index,4) && S(1,4)~=-1)
            S(1,4)=-1;
        end
        
        
        % Eliminating all General hypotheses which are inconsitent
        
      
        
        
    else
%      Remove from S any hypothesis inconsistent with d
          [S]=removeInconsistentRows(S,TrainData(index,:))

        [r c]=size(G);
        
        for idxG=1:length(G)
     
            if(G(idxG,1)==-1)
                r=r+1;
                G(r,:)=[S(1,1),G(1,2),G(1,3),G(1,4)];
                
            end
            if( G(idxG,2)~=-1)
                r=r+1;
                G(r,:)=[G(1,1),S(1,2),G(1,3),G(1,4)];
            end
            if(G(idxG,3)~=-1)
                r=r+1;
                G(r,:)=[G(1,1),G(1,2),S(1,3),G(1,4)];
            end
            if(G(idxG,4)~=-1)
                r=r+1;
                G(r,:)=[G(1,1),G(1,2),S(1,3),G(1,4)];
            end
            
            
        end
        
        
    end
end

% Selection of training data from the iris dataset

% List then Elimination example



% d is positive example
% d is negative example
