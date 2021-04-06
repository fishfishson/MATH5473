function [X,info] = mc_apg(D,Omega,X,alpha,tol,maxIts)

% This function solves the following matrix completion model 
% using the accelerated proximal gradient:
% min_X 0.5*\|P_Omega(D-X)\|_F^2 + alpha\|X\|_*  

% Please see section 4.2 in the introductary document
% Also see the comments in mc_softimpute
% The only difference from mc_softimpute is that the accelerated scheme
% (Nestrov) is implemented 

% Input --- 
% D:        input matrix
% Omega:    observed set
% X:        initial value of variable X
% alpha:    weight
% tol:      tolerance for convergence
% maxIts:   maximum iterations allowed
% Output ---
% X:        output low-rank matrix
% info:     relevant infomation

t = 1;
Y = X;
info.funVal = [];
for iter = 1:maxIts
    % step 4 in Algorithm 1
    C = D.*Omega + Y.*(1-Omega);
    % following codes implement singular value thresholding
    [U,W,V] = svd(C,'econ');
    VT = V';
    d = diag(W);
    idx = find(d > alpha);
    d = d(idx) - alpha;
    Xold = X;
    X = U(:,idx) * diag(d) * VT(idx,:);
    
    funVal = 0.5*norm((D-X).*Omega,'fro')^2 + alpha*sum(d);
    info.funVal = [info.funVal,funVal];
    
    % converged? if no, prepare for the next iteration
    if norm(X-Xold,'fro')/(norm(Xold,'fro')+eps) < tol
        break
    else 
        % implement the accelerated (nesterov) procedure
        % the if-else is added to implement the restart trick in the paper
        % B. O'Donoghue and E. J. Candès. Adaptive restart for accelerated gradient schemes.
        if iter > 1 && info.funVal(iter) > info.funVal(iter-1)
            told = 1;
            t = 1;
        else
            % step 5 in Algorithm 1
            told = t;
            t = (1+sqrt(1+4*t^2))/2;
        end
        % step 3 in Algorithm 1
        Y = X + (told-1)/t*(X-Xold);
    end
end
info.iter = iter;
end