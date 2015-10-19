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

% % % % % % % % % % % ListE alogirthm  % % % % % % % % % % % % % % % %  % % % % % %
S=[nan,nan,nan,nan];
G=[-1,-1,-1,-1];

AttrMat=Desc_Mat(:,1:4);
% Assigining Most General value to Attributes 
AttrMat(row+1,1:4)=G;

matAttr1=unique(AttrMat(:,1));
matAttr2=unique(AttrMat(:,2));
matAttr3=unique(AttrMat(:,3));
matAttr4=unique(AttrMat(:,4));
r=1;

% Finding all possible hypothises from the given data set.
for idx1=1:length(matAttr1)
    for idx2=1:length(matAttr2)
        for idx3=1:length(matAttr3)
            for idx4=1:length(matAttr4)
                H(r,:)=[matAttr1(idx1),matAttr2(idx2),matAttr3(idx3),matAttr4(idx4)];
                
                r=r+1;
            end
        end
    end
end
[r c]=size(H);
% Assigining Most Specific value to Attributes 
H(r+1,1:4)=S;

% initializing the version space with set of all possible hypothises 
VS=H;

for idxTD=1:length(TrainData)
    
    for idxVS=1:length(VS)
        temp=0;
        if(VS(idxVS,1)~=TrainData(idxTD,1) && VS(idxVS,1)~=-1)
          temp=1;  
        end
        if (VS(idxVS,2)~=TrainData(idxTD,2) && VS(idxVS,2)~=-1)
            temp=1;
        end
        if (VS(idxVS,3)~=TrainData(idxTD,3) && VS(idxVS,3)~=-1)
            temp=1;
        end
        
        if (VS(idxVS,4)~=TrainData(idxTD,4) && VS(idxVS,4)~=-1)
            temp=1;
        end
        
        if(temp==1)
           VS(idxVS,:)=nan;
        end
    end
end

% Removing the hypotheses  which are inconsistent with training data 
VS(~any(isnan(VS),2),:);
fprintf('\n VersionSpace that is consistent with the training data is \n');
disp(VS);






% for index=1:length(TrainData)
%     H
%     hx=
% end

% Selection of training data from the iris dataset

% List then Elimination example



% d is positive example
% d is negative example
