function [SwtImageModify_out] = swthole(SwtGuiyi)

height=size(SwtGuiyi,1);
width=size(SwtGuiyi,2);
SwtImageModify=SwtGuiyi;
% 

for i=2:height-1;
    for j=2:width-1;
% i=537;j=257;
            LL8=[];ll=0;
            
            for m=1:3;
                for n=1:3;
                    if SwtGuiyi(i+m-2,j+n-2)~=inf;
                        ll=ll+1;
                        LL8(ll)=SwtGuiyi(i+m-2,j+n-2);
                        
                    end
                end
            end
         if SwtGuiyi(i,j)~=inf   % black point      
            if ll<4   % 5
                for m=1:3;
                    for n=1:3;
                        SwtImageModify(i+m-2,j+n-2)=inf;
                    end
                end
            end
        else    
%             if (ll>5) && (min(LL8)*3>median(LL8))
%                 SwtImageModify(i,j)=mean(LL8);
%             end
                    
        end
    end
end


% for i=2:height-1;
%     for j=2:width-1;
% % i=537;j=257;
%             LL8=[];ll=0;           
%             for m=1:3;
%                 for n=1:3;
%                     if SwtGuiyi(i+m-2,j+n-2)~=255;
%                         ll=ll+1;
%                         LL8(ll)=SwtGuiyi(i+m-2,j+n-2);                      
%                     end
%                 end
%             end
%          if SwtGuiyi(i,j)~=255   % black point     
%             if ll<4
%                 for m=1:3;
%                     for n=1:3;
%                         SwtImageModify(i+m-2,j+n-2)=255;
%                     end
%                 end
%             end
%         else    
% %             if (ll>5) && (min(LL8)*3>median(LL8))
% %                 SwtImageModify(i,j)=mean(LL8);
% %             end                  
%         end
%     end
% end


SwtImageModify_out=SwtImageModify;