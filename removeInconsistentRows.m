function[h]=removeInconsistentRows(h,TrainData)
for idxh=1:length(h)
    temp=0;
    
    if(h(idxh,1)~=TrainData(1,1)  && h(idxh,1)~=-1)
        temp=1;
    end
    if (h(idxh,2)~=TrainData(1,2) && h(idxh,2)~=-1)
        temp=1;
    end
    if (h(idxh,3)~=TrainData(1,3) && h(idxh,3)~=-1)
        temp=1;
    end
    
    if (h(idxh,4)~=TrainData(1,4) && h(idxh,4)~=-1)
        temp=1;
    end
    
    if(temp==1 && TrainData(1,5)==1)
        h(idxVS,:)=nan;
    elseif(temp~=1 && TrainData(1,5)~=1)
        h(idxVS,:)=nan;
    end
end

h=h(~any(isnan(h),2),:);
end

