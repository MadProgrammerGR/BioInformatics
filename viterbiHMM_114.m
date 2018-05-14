
x = "GGCT";

% metatroph twn ACGT se deiktes 1234
% px "AGCGTC" = [1 3 2 3 4 2]
x(x=="A") = 1;
x(x=="C") = 2;
x(x=="G") = 3;
x(x=="T") = 4;
x = int32(x);

% pi8anothta ekkinhshs ka8e katastashs
P = [1/2 1/2];

%Aij = pi8anothta metavashs i -> j
A = [9/10 1/10;
     1/10 9/10];

%Bij = pi8anothta ekpomphs symvolou j apo thn katastash i 
    % A   C    G   T
B = [2/5 1/10 2/5 1/10;
     1/5 3/10 1/5 3/10];
    
n = length(x);
numStates = size(A,1);
S = zeros(numStates,n);


%arxikopoihsh gia thn prwth sthlh
S(:,1) = log(P')+log(B(:,x(1)));

for currLayer = 2:n
  for currState = 1:numStates
    %max(sysswreumenh pi8anothta se prohgoumenh katastash + metavash sthn twrinh katastash)
    m = max(S(:,currLayer-1)+log(A(:,currState)));
    %pi8anothta ekpomphs tou trexon symvolou apo thn twrinh katastash
    b = log(B(currState,x(currLayer)));
    %pros8esh autwn (oxi afairesh e3aitias logari8mwn)
    S(currState,currLayer) = b+m;
  endfor
endfor


%backtracking
[~,Path] = max(S(:,n)); %argmax teleutaias sthlhs
for currLayer = n:-1:2
  %vriskei apo poia katastash ypologisthke to S(:,currLayer)
  [~,Path(end+1)] = max(S(:,currLayer-1)+log(A(:,Path(end))));
endfor
Path = Path(end:-1:1); %reverse


fprintf("Logs of probabilities:\n");
S
p = S(Path(end),end);
fprintf("Log of best path's probability: %.8f\n",p);
fprintf("Without log... %.32f\n",e^p); %mporei na kanei ypoxeilish gia megales eisodous
fprintf("Best Path of states:\n");
Path
