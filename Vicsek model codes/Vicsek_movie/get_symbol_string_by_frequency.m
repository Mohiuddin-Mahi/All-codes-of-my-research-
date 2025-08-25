

function symbols_out=get_symbol_string_by_frequency(theta,num_symbols)

symbols_out=zeros(size(theta));                             % Initialize symbolized variables

for ind=1:1:size(theta,1)

    curr_theta=theta(ind,:);

    %% Sort the data in ascending order
    sorted_curr_theta=sort(curr_theta,'ascend');

    %% Calculate the number of data points in each bin
    bin_size= floor(length(curr_theta)/ num_symbols);

    %% Initialize variables to keep track of bin boundaries
    bin_edges = zeros(1, num_symbols + 1);

    %%% Calculate bin edges  %%%%
    bin_edges(1) = -Inf;                                   % To include the minimum value
    for i = 1:num_symbols-1
        bin_edges(i+1) = sorted_curr_theta(i*bin_size);
    end
    bin_edges(end) = Inf;                                  % To include the maximum value

    %%% Assign each data point to a symbol/bin %%%%
    for symbol_ind=1:num_symbols

        symbols_out(ind,curr_theta>=bin_edges(symbol_ind) & curr_theta <= bin_edges(symbol_ind+1)) = symbol_ind;

    end

end