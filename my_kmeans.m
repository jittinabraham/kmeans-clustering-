function [mu, class_im] = my_kmeans( Im, n_classes, init );
Im=rgb2lab(Im);
Im_A=Im(:,:,2);
Im_B=Im(:,:,3);
Im_A=Im_A(:);
Im_B=Im_B(:);

point_cordinates=[Im_A,Im_B];
%k_means clustering%
rand_init =randi(numel(Im_A),n_classes,init);
mu=point_cordinates(rand_init,:);
logDAold=zeros(length(Im_A)-1,n_classes);
logDBold=zeros(length(Im_B)-1,n_classes);
 n=1;
 tic;
while true
   
     x=mu(:,1)';
     Im_A(1,2:n_classes+1)=x;
     x=mu(:,2)';
     Im_B(1,2:n_classes+1)=x;
     
 for i=2:length(Im_A)
     distance=abs(Im_A(i,1)-Im_A(1,2:n_classes+1));
     [minD,inx]=min(distance);
     Im_A(i,inx+1)=minD;
     distance=abs(Im_B(i,1)-Im_B(1,2:n_classes+1));
     [minD,inx]=min(distance);
     Im_B(i,inx+1)=minD;
 end
 log_DA=Im_A(2:end,2:end)>0;
 log_DB=Im_B(2:end,2:end)>0;
 %update mu
 for i=1:n_classes
    MA=Im_A(2:end,1).*log_DA(:,i);
    mu(i,1)=sum(MA)/nnz(MA);
    MB=Im_B(2:end,1).*log_DB(:,i);
    mu(i,2)=sum(MB)/nnz(MB);
 end
  if isequal(log_DA, logDAold) && isequal(log_DB, logDBold)
        break;
   end
 Im_A(2:end,2:end)=0;
 Im_B(2:end,2:end)=0;
 logDAold= log_DA;
 logDBold =log_DB;
 n
 n=n+1;
end 
round(mu);
class_im(:,:,1)=log_DA;
class_im(:,:,2)=log_DB;
