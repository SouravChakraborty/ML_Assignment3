function[h]=findsAlgorithm(TrainData)

S=[0,0,0,0];
h=S;

for idx=1:length(TrainData)
    
    if(TrainData(idx,5)==1)
        if idx==1
            h=TrainData(1,1:4);
        end
        
        if(h(1,1)~=TrainData(idx,1) && h(1,1)~=-1)
            h(1,1)=-1;
            if (h(1,2)~=TrainData(idx,2) && h(1,1)~=-1)
                h(1,1)=-1;
                if (h(1,3)~=TrainData(idx,3) && h(1,1)~=-1)
                    h(1,1)=-1;
                    if (h(1,4)~= TrainData(idx,4) && h(1,1)~=-1)
                        h(1,1)=-1;
                        
                    end
                end
            end
            
        end
    end
end

    
