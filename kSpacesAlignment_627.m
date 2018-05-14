%fid = fopen("lactalbuminAlpha.sequence");
%v = strcat(textscan(fid, "%s"){1}{:});
%fclose(fid);
%fid = fopen("lysozyme.sequence");
%w = strcat(textscan(fid, "%s"){1}{:});
%fclose(fid);
%k = Inf; %megisto plh8os kenwn

v = "ATCTGATGGTAACTAAGATA";
w = "TGCATAATGACCAATAACTG";
k = 4; %megisto plh8os kenwn


n = length(v);
m = length(w);

%extra grammh/sthlh panw/aristera
S = zeros(n+1,m+1);%realmax*ones(n+1,m+1);
S(1,:) = 0:-1:-m; %arxikopoihsh poinwn
S(:,1) = 0:-1:-n; %arxikopoihsh poinwn

BlanksTotal = zeros(size(S));
BlanksTotal(1,:) = 0:m;
BlanksTotal(:,1) = 0:n;
Prev = zeros(size(S));
Prev(1,:) = 3; %mark gia aristera
Prev(:,1) = 2; %mark gia panw


%ana grammh 3ekinwntas apo th deuterh
for i = 2:(n+1)
  for j = max([2 i-k]):min([m+1 i+k])
    [S(i,j),argmax] = max([
      S(i-1,j-1) + (v(i-1)==w(j-1))*2 - 1,%1=bonus tairiasmatos,-1=poinh asymfwnias
      S(i-1,j) - 1 - (BlanksTotal(i-1,j)>=k)*realmax, %an exei hdh k kena to aporriptei, 
      S(i,j-1) - 1 - (BlanksTotal(i,j-1)>=k)*realmax, %apo thn epilogh tou max
    ]);

    %apo pou ypologisthke to S(i,j)
    Prev(i,j) = argmax;
    
    %apo8hkeush kenwn
    if(argmax==1)
      BlanksTotal(i,j) = BlanksTotal(i-1,j-1);
    elseif(argmax==2)
      BlanksTotal(i,j) = BlanksTotal(i-1,j) + 1;
    else
      BlanksTotal(i,j) = BlanksTotal(i,j-1) + 1;
    endif
    
  endfor
endfor


score = S(end,end)

[i,j] = size(S);
result = {};
Path = zeros(size(S));
count = 0;
while(!(i==1 && j==1))
  count = count + 1;
  Path(i,j) = count;
  
  if(i==1)%ftasame sth prwth grammh
    result{1}(end+1) = "-";
    result{2}(end+1) = w(j-1);
    j = j-1;
    continue;
  elseif(j==1)%ftasame sth prwth sthlh
    result{1}(end+1) = v(i-1);
    result{2}(end+1) = "-";
    i = i-1;
    continue;
  endif
  
  if(Prev(i,j)==1)%panw aristera
    result{1}(end+1) = v(i-1);
    result{2}(end+1) = w(j-1);
    i = i-1;
    j = j-1;    
  elseif(Prev(i,j)==2)%panw
    result{1}(end+1) = v(i-1);
    result{2}(end+1) = "-";    
    i = i-1;
  else%aristera
    result{1}(end+1) = "-";
    result{2}(end+1) = w(j-1);
    j = j-1;
  endif
  
endwhile
%reverse
result{1} = result{1}(end:-1:1);
result{2} = result{2}(end:-1:1);
%result
%S
%Path




