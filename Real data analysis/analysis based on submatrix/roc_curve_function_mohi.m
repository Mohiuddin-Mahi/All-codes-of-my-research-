
% Function "roc_curve" calculates the Receiver Operating Characteristic   %
% curve, which represents the FPR and TPR, of two classes of data, called %
% class_1 and class_2.                                                    %
%                                                                         %
%   Input parameters                                                      %
%       * class_1:  Column vector that represents data of the first class.%
%       * class_2:  Column vector that represents data of the second class%
%
%   Output variables
%       * AUC:     Area under ROC curve.                                  %
%       * TPR:     True positive rate (i.e.,Sensitivity ).                %
%       * FPR:     False positive rate (i.e.,1-Specifity ).               %

function [TPR,FPR,AUC] = roc_curve_function_mohi(class_1, class_2)

%% Calculating the threshold values between the data points %%%

s_data = unique(sort([class_1; class_2]));             % Sorted data points
s_data(isnan(s_data)) = [];                            % Delete NaN values
d_data = diff(s_data);                                 % Difference between consecutive points
d_data(length(d_data)+1,1) = d_data(length(d_data));   % Last point
thres(1,1) = s_data(1) - d_data(1);                    % First point
thres(2:length(s_data)+1,1) = s_data + d_data./2;      % Threshold values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calculating the TPR and FPR of each threshold %%%

TPR = zeros(size(thres,1),1);
FPR = zeros(size(thres,1),1);

for id_t = 1:1:length(thres)

    TP = length(find(class_2 >= thres(id_t)));    % True positives
    FP = length(find(class_1 >= thres(id_t)));    % False positives
    FN = length(find(class_2 < thres(id_t)));     % False negatives
    TN = length(find(class_1 < thres(id_t)));     % True negatives

    TPR(id_t,1) = TP/(TP + FN);                   % True positive rate or Sensitivity
    FPR(id_t,1) = FP/(TN + FP);	                  % False positive rate or 1-Specifity

end
AUC  = abs(trapz(FPR,TPR));                       % Area under curve
end