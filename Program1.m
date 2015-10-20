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


[VS]=ListE(Desc_Mat,TrainData);
fprintf('\n VersionSpace that is consistent with the training data is \n');
disp(VS);


% % % % % % % % % % % Candidate alogirthm  % % % % % % % % % % % % % % % %  % % % % % %
S=[nan,nan,nan,nan];
G=[-1,-1,-1,-1];
[tr tc]=size(TrainData);

for index=1:tr
    
    if(TrainData(index,5)==1)
        if(sum(isnan(S))==4)
            S(1,:)=TrainData(index,1:4);
        end
        %        Removing inconsistencies from G
        [G]=removeInconsistentRows(G,TrainData(index,:));
        
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
        % Remove from S any hypothesis inconsistent with d
        
        [S]=removeInconsistentRows(S,TrainData(index,:));
        %  Replacing any hypothesis in G with minimal specializations
        [Grws c]=size(G);
        
        for idxG=1:Grws
            [grc ,rc]=size(G);
            if(idxG>grc)
                break;
            end
            temp=0;
            if((G(idxG,1)==TrainData(index,1)) || (G(idxG,1)==-1))
                temp=temp+1;
            end
            if(G(idxG,2)==TrainData(index,2) || G(idxG,2)==-1)
                temp=temp+1;
            end
            if(G(idxG,3)==TrainData(index,3) || G(idxG,3)==-1)
                temp=temp+1;
            end
            if(G(idxG,4)==TrainData(index,4) || G(idxG,4)==-1)
                temp=temp+1;
            end
            
            
            if(temp==4)
                GgenIndex=find(G(idxG,:)==-1);
                if(~isempty(S))
                SgenIndex=find(S(1,:)==-1);
                end
                
                R=TrainData(index,GgenIndex(1,:));
                
                
                AttrMat=Desc_Mat(:,1:4);
                % Assigining Most General value to Attributes
                AttrMat(row+1,1:4)=[-1,-1,-1,-1];
                
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
                
                [rh ch]=size(H);
                for inx=1:rh
                    if(nnz(H(inx,:)==-1)~=length(GgenIndex)-1)
                        H(inx,:)=nan;
                    end
                    
                    for len=1:length(R)
                        if(H(inx,len)==R(1,len))
                            H(inx,:)=nan;
                            break;
                        end
                    end
                    for len=1:length(S)
                        if(S(1,len)==-1 && H(inx,len)~=S(1,len))
                            H(inx,:)=nan;
                            break;
                        end
                    end
                    
                end
                
                  H=H(~any(isnan(H),2),:);
              
                  G(idxG,:)=nan;
                  G=G(~any(isnan(G),2),:);
                  G=vertcat(G,H);
                  G=unique(G,'rows');
                  
                 [ wr wc]=size(G);
                 rlength=0;
                 
                  for irdx=1:wr
                      if(rlength==0)
                      rlength=nnz(G(irdx,:)==-1);
                      end
                      if(rlength<=nnz(G(irdx,:)==-1))
                           rlength=nnz(G(irdx,:)==-1);
                      else 
                        G(irdx,:)=nan;  
                      end
                  end
                  
                    G=G(~any(isnan(G),2),:);
                   
                    
            end
            
          
            
        end
        
        
    end
end

fprintf('\n Specification hypotheses set for given dataset in Candidate Algorithm \n');
disp(S);
fprintf('\n Generalization hypotheses set for given dataset in Candidate Algorithm \n');
disp(G);


