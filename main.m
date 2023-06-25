clear all
close all
Im = imread('strawberry.jpg');
Im=imresize(Im,0.5);

Im=im2double(Im);
[r,c]=size(Im(:,:,1));
n_classes=4;
init=1;
[mu, class_im] = my_kmeans( Im, n_classes, init );

 T1=mu(:,1);
 T2=mu(:,2);
CA=class_im(:,:,1)*T1;
CB=class_im(:,:,2)*T2;
CA(end+1)=0;
CB(end+1)=0;
IAcls=reshape(CA,r,c);
IBcls=reshape(CB,r,c);



hold on;
for i=1:n_classes
   cluster_image = IAcls==mu(i,1);
   figure();
   hold on;
  imshow(cluster_image);
   
      
    
end
lab=zeros(r,c,3);
lab(:,:,2)=IAcls;
lab(:,:,3)=IBcls;
lab(:,:,1)=10;

rgbIm_clusterd=lab2rgb(lab);
imshow(rgbIm_clusterd);

  
