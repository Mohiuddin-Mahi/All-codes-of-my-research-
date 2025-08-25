
function index=Otsu_method_function(tifimage)

%% Read Image
Img= tifimage;
[rows,cols,dims] = size(Img);

%% If RGB convert it to gray
if dims == 3
    Img = rgb2gray(Img);
end
Img = double(Img);

%% Convert it to 8 bits
Img = uint8(255 * (Img - min(Img(:))) / (max(Img(:)) - min(Img(:))));
[Frequency,~] = imhist(Img);
mg = mean(Img(:));

%% Let the threshold value varies from k = 0 to 255
BetClassvariance = zeros(1,256);
Goodness = BetClassvariance;
NormalizedFreq = Frequency / (rows * cols);
SigmaGlobal = var(double(Img(:)));
%% We are starting from k 1 till 254 because at k=0, P1 = 0 and at k = 255,
%% P1 = 1 therefore P2 = 1 - P1 = 0;
for k = 1:255-1
    P1 = sum(NormalizedFreq(1:k+1));
    mk = sum((NormalizedFreq(1:k+1) .* (0:k)')); 
    BetClassvariance(k+1) = (mg * P1 - mk)^2 / (P1 * (1 - P1));
    Goodness(k+1) = BetClassvariance(k+1) / SigmaGlobal;
end
[~,index]= max(BetClassvariance);

% % figure,plot(BetClassvariance);xlabel('Threshold Values'),ylabel('Between Class Variance');
% % hold on, line([index index],[0 max(BetClassvariance)],'Color',[1 0 0]);
% % title('Frame 500')
% % set(gca,'fontsize',14)
