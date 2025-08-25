
function [symbols]=function_Boolean_model(tmax,nbird,wmat,Theta,gamma)

%%%% Initialize states %%%%
symbols = zeros(tmax, nbird);           
symbols(1, :) = randi([0, 1], 1, nbird); 

for t = 1:tmax-1
    for i = 1:nbird

        neighbour_influence = sum(wmat(i, :) .* symbols(t, :));       

        prob = Theta * (1 + gamma * neighbour_influence);

        symbols(t+1, i) = rand <= prob; 
    end
end

end

