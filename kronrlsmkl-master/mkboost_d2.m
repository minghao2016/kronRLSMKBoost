function [O] = mkboost_d2(y_train, kernels, dist, lambda, num_ones)
	%disp(size(kernels,2)); return;
	%parameters
        T = 80;
	%n = 
	alpha = zeros(T,size(kernels,2));
	alpha1 = zeros(1,T); 
	h = cell(1,T);
        for t=1:T
		%disp(t);
		%call the sampling here
		%[] = sample_example();
		loss = realmax('single');
		best_kernel_index = -1;
		%h{t} = zeros(
		losses = [];
		alpha = [];
		predicted = cell(1,size(kernels,2));
		for j=1:size(kernels,2)
			%disp(j);
			%train a week classifier/predictor with kernel k_j
			temp = kernels{1,j};
			%disp(size(temp));
			[A] = kronrls(double(temp{1}), double(temp{2}), y_train, lambda); 		
			[current_loss, p] = getLoss_1(A, y_train, num_ones, dist);
			if(current_loss>1)
				disp(current_loss); return;
			end
			predicted{j} = p;
			losses = [losses current_loss]; 
			alpha(t,j) = 0.5 * log((1-current_loss)/(current_loss)); 
			if(~isreal(alpha1(t)))		
			disp(current_loss); %return;
			end			
		end		
		
		%combine the classifiers
		h{t} = alpha(t,1) .* predicted{1};
		for j=2:size(kernels,2)
			h{t} = h{t} + alpha(t,j) .* predicted{j};
		end
	
		[current_loss] = getLoss_1(h{t}, y_train, num_ones, dist); 
		alpha1(t) = 0.5 * log((1-current_loss)/(current_loss));
		%if(~isreal(alpha1(t)))		
		%	disp(current_loss); return;
		%end 
		old_dist = dist(:,:);
		for dist_i=1:size(dist,1)
			for dist_j=1:size(dist,2)
				%if y_train(dist_i, dist_j) == 1		
					if h{t}(dist_i, dist_j)==(y_train(dist_i, dist_j))		
						%disp('if');
						dist(dist_i, dist_j)=old_dist(dist_i, dist_j) * exp((-alpha1(t)));
					else
						%disp('else');
						dist(dist_i, dist_j)=old_dist(dist_i, dist_j) * exp((alpha1(t)));
					end
				%end
			end
		end
		sum_dist = sum(sum(dist));
		dist = dist ./ sum_dist;
		
	end
	%disp(alpha1);
	%disp(best_kernel);
	%return;
	O = zeros(size(h{1}));
	for t = 1:T
		O = O + alpha1(t) .* h{t};
	end
end

function [] = sample_examples()
	
end

%computes absolute loss
function [loss, predicted] = getLoss_1(predicted, original, num_ones, dist)
	%predicted = predicted .* dist;
	
	for i=1:size(predicted,1)
		for j=1:size(predicted,2)
			if predicted(i,j)>0.08
				predicted(i,j)=1;
			else
				predicted(i,j)=0;
			end
		end
	end
	loss_matrix = abs(original-predicted); %.* dist;
	loss = 0;
	for i=1:size(predicted,1)
		for j=1:size(predicted,2)
			if predicted(i,j)~=original(i,j)
				%if(~isreal(dist(i,j)))
				%	disp(dist(i,j)); return;
				%end
				loss = loss + dist(i,j);
			end	
		end
	end

	
	%loss_matrix = loss_matrix ./ original;
	%end
	%loss = sum(sum(loss_matrix));	%disp(loss);
	%loss = sum(sum(loss_matrix))/ num_ones; %disp(loss); return;
	%loss = sum(sum(loss_matrix)); 
	%disp(sum(sum(loss_matrix))); return;
end
