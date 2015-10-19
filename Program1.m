load('iris.dat.mat');
% Descritizing the dataset 
Desc_Mat=floor(Data+1);

[row column]=size(Desc_Mat);

% partitioning the data as Training and Testing data
randIdx=randperm(row);
trainIdx=randIdx(1,1:100);
testIdx=randIdx(1,100:150);

TrainData=Desc_Mat(trainIdx,:);
TestData=Desc_Mat(testIdx,:);

% % % % % % % % % % % Find-S alogirthm  % % % % % % % % % % % % % % % %  % % % % % %

[h]=findsAlgorithm(TrainData)
%     Output hypothesis from the Find-S Alogirthm is
printf('Output hypothesis from the Find-S Alogirthm\n')
disp(h);



% % % % % % % % % % % Candidate Alogrithm  % %  % % %  % % % % 

AttrMat=Desc_Mat(:,1:4);
AttrMat(row+1,1:4)=G;
AttrMat(row+2,1:4)=S;

matAttr1=unique(AttrMat(:,1));
matAttr2=unique(AttrMat(:,2));
matAttr3=unique(AttrMat(:,3));
matAttr4=unique(AttrMat(:,4));
r=1;
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

H;






% for index=1:length(TrainData)
%     H
%     hx=
% end

% Selection of training data from the iris dataset

% List then Elimination example



% d is positive example
% d is negative example
