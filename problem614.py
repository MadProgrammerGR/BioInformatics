from Bio import SeqIO

x=len(SeqIO.read('phosphorylaseLiver.fasta','fasta'))
y=len(SeqIO.read('phosphorylaseMuscle.fasta','fasta'))

if x<y:
    x,y=y,x
if (x == y and x % 3 == 2) or (y==x-1 and y%3!=1) or (y%3==1):
    print("Player 2 wins")
else:
    print("Player 1 wins")
