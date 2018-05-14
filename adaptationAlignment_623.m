v = "GTAGGCTTAAGGTTA";
w = "TAGATA";
%v = "ATCTGAT";
%w = "TGCATAACCAGT";


n = length(v);
m = length(w);
S = zeros(n+1,m+1); %extra prwth grammh/sthlh
S(1,:) = 0:-1:-m; %arxikopoihsh poinwn
%..h prwth sthlh menei me mhdenika gia na 3ekinaei h stoixish apo opoiadhpote grammh


%ana sthlh 3ekinwntas apo th deuterh
for j = 2:(m+1)
  for i = 2:(n+1)
    S(i,j) = max([
      S(i-1,j) - 1, % -1 == poinh pros8afairesewn
      S(i,j-1) - 1,
      S(i-1,j-1) + (v(i-1)==w(j-1))*2 - 1 %1=bonus tairiasmatos,-1=poinhs asymfwnias
    ]);
  endfor
endfor



%h stoixish prosarmoghs teleiwnei sto megalytero stoixeio ths teleutaias sthlhs
%sth periptwsh pollwn stoixeiwn dialegetai to prwto
[score,i] = max(S(:,end))
fprintf("Score: %d\n",score);

j = m+1;
result = {};
Path = zeros(size(S));
count = 0;
while(j!=1)
  count = count + 1;
  Path(i,j) = count;
  
  if(i==1)%an ftasame sth prwth grammh
    result{1}(end+1) = "-";
    result{2}(end+1) = w(j-1);
    j = j-1;
    continue;
  endif
  
  if(S(i,j)==S(i,j-1)-1)%an to vrhke erxontas apo aristera
    result{1}(end+1) = "-";
    result{2}(end+1) = w(j-1);
    j = j-1;
  elseif(S(i,j)==S(i-1,j)-1)%erxontas apo panw
    result{1}(end+1) = v(i-1);
    result{2}(end+1) = "-";    
    i = i-1;
  else%erxontas apo panw aristera
    result{1}(end+1) = v(i-1);
    result{2}(end+1) = w(j-1);
    i = i-1;
    j = j-1;
  endif
  
endwhile
%reverse
result{1} = result{1}(end:-1:1);
result{2} = result{2}(end:-1:1);
result
S
Path

