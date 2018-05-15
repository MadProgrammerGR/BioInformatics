import sys
import random as rd

def lose_position(x,y):
    if x<y:
        x,y=y,x
    return (x == y and x % 3 == 2) or (y==x-1 and y%3!=1) or (y%3==1)
def valid_moves(x,y):
    moves=[]
    if x-1>=0 and y-2>=0:
        moves+=[(x-1,y-2)]
    if x-2>=0 and y-1>=0:
        moves+=[(x-2,y-1)]
    return moves

try:
    x,y = int(sys.argv[1]),int(sys.argv[2])
except:
    print('plz run it from cmd like this "python biopl6.14 X Y "')
    sys.exit(0)
    
turn = True

while 1:
    vm = valid_moves(x,y)
    if vm==[]:
        if turn:
            print("You won!.")
            break
        else:
            print("You lost.")
        break
    if turn:
        for i in range(len(vm)):
            print(i,vm[i])
        print("Select your move")
        while 1:
            a=int(input())
            if a in range(len(vm)):
                break
        x,y=vm[a]
        turn = not turn
    else:
        for x1,y1 in vm:
            if lose_position(x1,y1):
                x,y= x1,y1
                break
        if (x,y) not in vm:
            x,y = rd.choice(vm)
        print("computer plays",x,y)
        turn = not turn
    
    
    
    
