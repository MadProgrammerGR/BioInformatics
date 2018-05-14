fprintf("Give numbers in array syntax format, e.g. [12 10]\n");
tmp = input('');
n = tmp(1);
m = tmp(2);

myturn = 1;
while(n!=1 || m!=1) %oso toulaxiston enas ari8mos mporei na spasei
  if(myturn)
    %diale3e ton artio ari8mo k spaston tyxaia se dyo perittous
    if(n!=0 && mod(n,2)==0)
      m = 2*randi(n/2) - 1; %tyxaio peritto ari8mo sto [1,n-1]
      n = n - m; %n = to ypoloipo
    elseif(m!=0 && mod(m,2)==0)
      n = 2*randi(m/2) - 1;
      m = m - n;
    else %eimaste se meionekthma... diale3e sth tyxh
      r = [n m](randi(2)); %r == o ari8mos pou spaei sta dyo
      n = randi(r-1);
      m = r - n;
    endif
    fprintf("[%d %d]\n",n,m);
    
  else %gyros tou paixth
    tmp = input('');
    while(!ismember(sum(tmp),[n m]))
      tmp = input(sprintf("Numbers must add up to either %d or %d\n",n,m));
    endwhile
    n = tmp(1);
    m = tmp(2);
  endif
  
  myturn = !myturn;
endwhile

if(myturn)
  fprintf("You won! GG\n");
else
  fprintf("No more moves...\nDont worry it's not your fault, Dynamic Programming is to blame!\n");
endif
