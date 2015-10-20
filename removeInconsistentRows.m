function[h]=removeInconsistentRows(h,TData)
[rwh,c]=size(h);

for idxh=1:rwh
    temp=0;
     [rwhc,c]=size(h);
            if(idxh>rwhc)
                break;
            end
    if(h(idxh,1)~=TData(1,1)  && h(idxh,1)~=-1)
        temp=1;
    end
    if (h(idxh,2)~=TData(1,2) && h(idxh,2)~=-1)
        temp=1;
    end
    if (h(idxh,3)~=TData(1,3) && h(idxh,3)~=-1)
        temp=1;
    end
    
    if (h(idxh,4)~=TData(1,4) && h(idxh,4)~=-1)
        temp=1;
    end
    
    if(temp==1 && TData(1,5)==1)
        h(idxh,:)=nan;
        h=h(~any(isnan(h),2),:);
    elseif(temp~=1 && TData(1,5)~=1)
        h(idxh,:)=nan;
        h=h(~any(isnan(h),2),:);
    end
end


end

