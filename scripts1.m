P = readtable('test2.csv');
T = table2cell(P);
T(:,5) = [];
D2 = cell2mat(T);
x=1:1:size(D2,1);

g= D2(:,4)==1;
b= D2(:,4)==0;
G= D2;Gav = D2;
B=D2;Bav = D2;
G(b,:)=NaN; %good mx
B(g,:)=NaN; %bad mx

figure(1)
title('RSSI vs Time');
xlabel('time samples') % x-axis label
ylabel('RSSI') % y-axis label




hold on
plot(G(:,1),'o');
plot(B(:,1),'*');
hold off;
saveas(figure(1),'rssi.png') 

figure(2)
hold on
plot(G(:,3),'o');
plot(B(:,3),'*');
hold off;
saveas(figure(2),'duration.png') 

Gav(b,:)=[]; %good mx
Bav(g,:)=[]; %bad mx

bm = mean(Bav,'omitnan')
gm = mean(Gav,'omitnan')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -90 -> -80\

A = D2(:,1)< -55 ;
A = D2(:,1)> -80;
C1 = D2(A,:);

gc1 = C1(:,4) == 1;bc1 = C1(:,4) == 0; GC1 = C1;
GC1av = C1;
BC1=C1;BC1av = C1;GC1av(bc1,:)=[]; %good mx
BC1av(gc1,:)=[]; %bad mx

bcm1 = sum(BC1av,'omitnan')
gcm1 = sum(GC1av,'omitnan')

gcmS1 = gcm1(:,4);
N = size(D2(:,1));
N = size(C1(:,1));

gcmSP1= gcmS1(:,1)/N(:,1);gcmSPn1 = (1-gcmSP1)*100;
gcmSP1= gcmSP1*100; 
RSSIC1(1,1) = gcmSP1;
RSSIC1(1,2) = gcmSPn1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -90 -> -80\

A = D2(:,1)< -35;
A = D2(:,1)> -54;
C = D2(A,:);

gc = C(:,4) == 1;bc = C(:,4) == 0; GC = C;GCav = C;
BC=C;BCav = C;GCav(bc,:)=[]; %good mx
BCav(gc,:)=[]; %bad mx

bcm = sum(BCav,'omitnan')
gcm = sum(GCav,'omitnan')

gcmS = gcm(:,4);
N = size(D2(:,1));
N = size(C(:,1));

gcmSP= gcmS(:,1)/N(:,1);gcmSPn = (1-gcmSP)*100;
gcmSP= gcmSP*100;
RSSIC2(1,1) = gcmSP;
RSSIC2(1,2) = gcmSPn;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -30 -> -50\

A = D2(:,1)< 20;
A = D2(:,1)> -34;
C2 = D2(A,:);

gc2 = C2(:,4) == 1;bc2 = C2(:,4) == 0; GC2 = C2;GCav2 = C2;
BC2=C2;BCav2 = C2;GCav2(bc2,:)=[]; %good mx
BCav2(gc2,:)=[]; %bad mx

bcm2 = sum(BCav2,'omitnan')
gcm2 = sum(GCav2,'omitnan')

gcmS2 = gcm2(:,4);
N = size(D2(:,1));
N = size(C2(:,1));

gcmSP2= gcmS2(:,1)/N(:,1);gcmSPn2 = (1-gcmSP2)*100;
gcmSP2= gcmSP2*100;
RSSIC3 (1,1) = gcmSP2;
RSSIC3(1,2) = gcmSPn2;


RSSIP = [RSSIC1; RSSIC2; RSSIC3];
figure(3);


bar(RSSIP,'stacked');
title('percentage of corrupt packets w.r.t RSSI (dBm)');

xlabel('-80 -55          -54 -35          -34 +20') % x-axis label
ylabel('percentage of corrupt packets') % y-axis label
saveas(figure(3),'bar_graph.png') ;

%exit
