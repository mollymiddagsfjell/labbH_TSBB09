%%
fp = fopen(['handran'],'r');
a = fscanf(fp,'%d',[500,256]); % image size:  500*256
figure(1)
%imagesc(a);
imagesc(a,[0,100]);
axis image; colorbar;
colormap([(0:255)'/255,(0:255)'/255,(0:255)'/255])
%%
% pseudo intensity image handint

fp = fopen(['handint'],'r');
b = fscanf(fp,'%d',[500,256]); % image size:  500*256
figure(2)
imagesc(b);
axis image; colorbar;
colormap([(0:255)'/255,(0:255)'/255,(0:255)'/255])

%%
% Combine a och b
T = 36;
figure(3);
c = a.*(b>T); 
imagesc(c);
axis image; colorbar;
%colormap gray
rainbow = jet;

%uncertain values in gray
rainbow(1,:) = [0.5 0.5 0.5];
colormap(rainbow)

%%
fp=fopen(['musran'],'r');
b = fscanf(fp,'%d',[250,256]); % image size:  250*256
figure(4);
imagesc(b);

%%
fp = fopen(['wood'],'r');
g = fscanf(fp,'%d',[512,512]); % image size:  512*512
figure(5)
imagesc(g);

%%
[y,i] = max(g, [], 1);
figure(6)
plot(i)

%%
j = y;
%j = j < 250;
i(j<250) = NaN;
plot(i);

%%
imagesc(trapez)
u = [174 124 141 205];
v = [72 136 389 472];

trap = inv(C') * [v; u; ones(1,length(u))];
%norm
trap = [trap(1,:)./trap(3,:); trap(2,:)./trap(3,:); trap(3,:)./trap(3,:)];
cirTra = sum(norm(trap(:,1)-trap(:,2)) + norm(trap(:,2)-trap(:,3)) + norm(trap(:,3)-trap(:,4)) + norm(trap(:,4)-trap(:,1))); 

%% Card
load cardim
rangeim

tick_divide = 4;
r = rangeim.range;
y = rangeim.x;
x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1) 1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;

%load range data
%mesh(R1(:,:,3)); axis equal
mesh(R1(:,:,1),R1(:,:,2),R1(:,:,3)); axis equal

%% Letter
load letter.mat
rangeim

tick_divide = 4;
r = rangeim.range;
y = rangeim.x;
x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1) 1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;

%load range data
%mesh(R1(:,:,3)); axis equal
mesh(R1(:,:,1),R1(:,:,2),R1(:,:,3)); axis equal

%% Vit väggkontakt

load vit_vaggkontakt
rangeim;

tick_divide = 4.14;
r = rangeim.range;
y = rangeim.x;
x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1) 1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;

R2 = R1(401:700,201:700,:);
Intens = rangeim.intens(401:700,201:700);
figure(1)
%distortion removal
R2(R2(:,:,3) > 455) = NaN;
meshc(R2(:,:,1),R2(:,:,2),R2(:,:,3))
figure(2)
subplot(2,2,1), imagesc(R2(:,:,1)), title('y image'); axis equal
subplot(2,2,2), imagesc(R2(:,:,2)), title('x image');axis equal
subplot(2,2,3), imagesc(R2(:,:,3)), title('r image');axis equal
subplot(2,2,4), imagesc(Intens(:,:)), title('i image');axis equal
figure(3)
subplot(2,2,1), plot(R2(:,320,1)), title('vert, y');axis equal
subplot(2,2,2), plot(R2(150,:,2)), title('horiz, x');axis equal
subplot(2,2,3), plot(R2(:,320,3)), title('vert, r');axis equal
subplot(2,2,4), plot(R2(150,:,3)), title('horiz, r');axis equal

%%

load hus90;
rangeim;

tick_divide = 4.14;
r = rangeim.range;
y = rangeim.x;
x = repmat(double(rangeim.prof_id)/tick_divide,[size(y,1) 1]);
imsz = size(r);
R1 = zeros([imsz 3]);
R1(:,:,1) = double(y);
R1(:,:,2) = double(x);
R1(:,:,3) = double(r);
cert = (r == 0);
R1c = repmat(cert,[1 1 3]);
R1(R1c) = NaN;

R2 = R1(401:700,201:700,:);
Intens = rangeim.intens(401:700,201:700);
figure(1)
%distortion removal
meshc(R2(122:198,110:368,1),R2(122:198,110:368,2),R2(122:198,110:368,3)-400)
figure(2)
subplot(2,2,1), imagesc(R2(:,:,1)), title('y image'); axis equal
subplot(2,2,2), imagesc(R2(:,:,2)), title('x image');axis equal
subplot(2,2,3), imagesc(R2(:,:,3)), title('r image');axis equal
subplot(2,2,4), imagesc(Intens(:,:)), title('i image');axis equal
figure(3)
subplot(2,2,1), plot(R2(:,320,1)), title('vert, y');axis equal
subplot(2,2,2), plot(R2(150,:,2)), title('horiz, x');axis equal
subplot(2,2,3), plot(R2(:,320,3)), title('vert, r');axis equal
subplot(2,2,4), plot(R2(150,:,3)), title('horiz, r');axis equal


deltax = (525.9-497)/(198-122);
deltay = (134.4 - 75.12)/(368 - 110);

R2Diff = zeros(size(R2(:,:,1)));
R2Diff(1:end-1,:) = diff(R2(:,:,1));
volHus = (R2(:,:,3) - 401.5).*R2Diff*(1/tick_divide).*(R2(:,:,3)>410);
imagesc(volHus)
nansum(nansum(volHus))/1000

volume = sum(nansum(R2(122:198,110:368,3)-401))/1000*deltax*deltay;
