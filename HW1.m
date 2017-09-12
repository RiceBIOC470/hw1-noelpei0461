% Homework 1. Due before class on 9/5/17

%% Problem 1 - addition with strings

% Fill in the blank space in this section with code that will add 
% the two numbers regardless of variable type. Hint see the matlab
% functions ischar, isnumeric, and str2num. 

%your code should work no matter which of these lines is uncommented. 
x = 3; y = 5; % integers
%x = '3'; y= '5'; %strings
% x = 3; y = '5'; %mixed

%your code goes here
if isnumeric(x)==0
    x=str2num(x);
end
if isnumeric(y)==0
    y=str2num(y)
end

z=x+y;
disp(z)
%output your answer
8
%% Problem 2 - our first real biology problem. Open reading frames and nested loops.

%part 1: write a piece of code that creates a random DNA sequence of length
% N (i.e. consisting of the letters ATGC) where we will start with N=500 base pairs (b.p.).
% store the output in a variable
% called rand_seq. Hint: the function randi may be useful. 
% Even if you have access to the bioinformatics toolbox, 
% do not use the builtin function randseq for this part. 

N = 500; % define sequence length

s=randi(4,1,500)
% set up an array with 500 random numbers, range 1 to 4 in it.
d=''
for ii=1:500
    if s(ii)==1
        d(ii)='A'
    elseif s(ii)==2
        d(ii)='T'
    elseif s(ii)==3
        d(ii)='G'
    else d(ii)='C'
    end
%For every 1 in s, input A in d; and substitue rest values as well.
end

d
% d is the string with 500 random ATGC in it.
%part 2: open reading frames (ORFs) are pieces of DNA that can be
% transcribed and translated. They start with a start codon (ATG) and end with a
% stop codon (TAA, TGA, or TAG). Write a piece of code that finds the longest ORF 
% in your seqeunce rand_seq. Hint: see the function strfind.
d
k=strfind(d,'ATG');
% find the location of all start condons 
len=length(k);
% find how many start condons are in it.
dist=[];
% dist is used to store every possible combination of a start codon to stop condons.
dist2=[];
% dist2 is used to store all the ORF length.
g=1;
for i=1:len
    for ii=k(i)+3:3:498
        if d(ii:ii+2)=='TAA'
            m=ii;
            dist(g)=m-k(i);
            g=g+1;
        elseif d(ii:ii+2)=='TAG'
            m=ii;
            dist(g)=m-k(i);
            g=g+1;
        elseif d(ii:ii+2)=='TGA'
            m=ii;
            dist(g)=m-k(i);
            g=g+1;
        %find all stop codons after the start codon.
        end
    end
    A=min(dist);
    % the smallest start/stop codon combination is the real ORF we are looking for.
    if isempty(A)
        A=0
    end
    % for the sequence that does not have any stop codon after their start codons, set the value of the length of ORF as 0. 
    dist2(i)=A;
    
end
distmax=max(dist2)
%show the longest ORF in dist2.

%part 3: copy your code in parts 1 and 2 but place it inside a loop that
% runs 1000 times. Use this to determine the probability
% that an sequence of length 500 has an ORF of greater than 50 b.p.
a=0
% a is the parameter used to express how many ORFs satisfied the requirement. 
for i=1:1000
% run 1000 times.
    s=randi(4,1,500);
    d='';
    for ii=1:500
        if s(ii)==1
            d(ii)='A';
        elseif s(ii)==2
            d(ii)='T';
        elseif s(ii)==3
            d(ii)='G';
        else d(ii)='C';
        end
    end
    k=strfind(d,'ATG');
    len=length(k);
    dist=[];
    dist2=[];
    g=1;
    for i=1:len
        for ii=k(i)+3:3:498
            if d(ii:ii+2)=='TAA'
                m=ii;
                dist(g)=m-k(i);
                g=g+1;
            elseif d(ii:ii+2)=='TAG'
                m=ii;
                dist(g)=m-k(i);
                g=g+1;
            elseif d(ii:ii+2)=='TGA'
                m=ii;
                dist(g)=m-k(i);
                g=g+1;
            end
        end
        A=min(dist);
        if isempty(A)
            A=0;
        end
        dist2(i)=A;
    end
    distmax=max(dist2)
    % Judge for each time when we found an ORF, if that is greater than 50, then a=a+a
    if distmax>50
        a=a+1;
    else
        a=a;
    end
end
xx=a/1000;
disp(xx)
% possibility
%part 4: copy your code from part 3 but put it inside yet another loop,
% this time over the sequence length N. Plot the probability of having an
% ORF > 50 b.p. as a funciton of the sequence length. 
function Css=Possibility(N)
    Rxx=[];
    %Rxx is an array that will be used to store the possibility values
    for xxx=3:N
        a=0;
        for i=1:1000
            s=randi(4,1,xxx);
            d='';
            for ii=1:xxx
                if s(ii)==1
                    d(ii)='A';
                elseif s(ii)==2
                    d(ii)='T';
                elseif s(ii)==3
                    d(ii)='G';
                else d(ii)='C';
                end
            end
            k=strfind(d,'ATG');
            len=length(k);
            dist=[];
            dist2=[];
            g=1;
            for i=1:len
                for ii=k(i)+3:3:xxx-2
                    if d(ii:ii+2)=='TAA'
                        m=ii;
                        dist(g)=m-k(i);
                        g=g+1;
                    elseif d(ii:ii+2)=='TAG'
                        m=ii;
                        dist(g)=m-k(i);
                        g=g+1;
                    elseif d(ii:ii+2)=='TGA'
                        m=ii;
                        dist(g)=m-k(i);
                        g=g+1;
                    end
                end
                A=min(dist);
                if isempty(A)
                    A=0;
                end
                dist2(i)=A;
            end
            distmax=max(dist2);
            if distmax>50
                a=a+1;
            else
                a=a;
            end
        end
        xx=a/1000;
        Rxx(N)=xx;
    end
xval=[1:N]
yval=Rxx(1:N)
Css=plot(xval,yval)
end

Possibility(N)
% this will give us the plot of the sequence that contains N bps.

%part 5: Make sure your results from part 4 are sensible. What features
% must this curve have (hint: what should be the value when N is small or when
% N is very large? how should the curve change in between?) Make sure your
% plot looks like this. 

%Answer:
%When N<50, which means the sequence length is less than 50 bps, the y value is 0, because find an ORF whose length is greater than 50 bps in a sequence less than 50bps is impossible.
%Then the y value increases dramatically, meaning ORFs length greater than 50bps start showing up. Then, when N is very large, it will reach its limit at around 0.5, meaning although the sequence length is enough for ORFs longer than 50 bps to be find, the actual possiblity may be restrict by other factors as well.



%% problem 3 data input/output and simple analysis

%The file qPCRdata.txt is an actual file that comes from a Roche
%LightCycler qPCR machine. The important columns are the Cp which tells
%you the cycle of amplification and the position which tells you the well
%from the 96 well plate. Each column of the plate has a different gene and
%each row has a different condition. Each gene in done in triplicates so
%columns 1-3 are the same gene, columns 4-6 the same, etc.
%so A1-A3 are gene 1 condition 1, B1-B3 gene 1 condition 2, A4-A6 gene 2
%condition 1, B4-B6 gene2 condition 2 etc. 

% part1: write code to read the Cp data from this file into a vector. You can ignore the last two
% rows with positions beginning with G and H as there were no samples here. 
qPCRdata='qPCRdata.txt'
fid = fopen(qPCRdata,'r');
data = textscan(fid,'%*s%*f%s%*s%f%*s%*s%*s%[^\n]','Delimiter','\t','HeaderLines',2);
Cp = cell2mat(data(1,2));
Cp=Cp';
Cp
%Cp is the vector that we are looking for
% Part 2: transform this vector into an array representing the layout of
% the plate. e.g. a 6 row, 12 column array should that data(1,1) = Cp from
% A1, data(1,2) = Cp from A2, data(2,1) = Cp from B1 etc. 
Cpc=reshape(Cp,[12,8])
data=Cpc'
%directly assign them into a 12*8 matrix, then convert rows into columns.
% Part 3. The 4th gene in columns 10 - 12 is known as a normalization gene.
% That is, it's should not change between conditions and it is used to normalize 
% the expression values for the others. For the other three
% genes, compute their normalized expression in all  conditions, normalized to condition 1. 
% In other words, the fold change between these conditions and condition 1. The
% formula for this is 2^[Cp0 - CpX - (CpN0 - CpNX)] where Cp0 is the Cp for
% the gene in the 1st condition, CpX is the value of Cp in condition X and
% CpN0 and CpNX are the same quantitites for the normalization gene.
% Plot this data in an appropriate way. 
Agene=Cpcc(1:6,1:3);
Bgene=Cpcc(1:6,4:6);
Cgene=Cpcc(1:6,7:9);
Dgene=Cpcc(1:6,10:12);

AverageA=mean(Agene);
AverageB=mean(Bgene);
AverageC=mean(Cgene);
AverageD=mean(Dgene);
%get average value for each gene in each condition

all=[AverageA;AverageB;AverageC;AverageD];

Norm=[];

for i=1:3
    for ii=1:6
       Norm(i,ii)=2^(all(i,1)-all(i,ii)-(all(4,1)-all(4,ii)));
       %set condition 1 as the default for both gene. i row means the ith gene, ii means the condition, which is devided into 12 parts. 
    end
end
Norm
%Norm contains all normalized data of the three gene
NormA=Norm(1,1:6);
NormB=Norm(2,1:6);
NormC=Norm(3,1:6);

plot(NormA,'r--')
hold on;
plot(NormB,'b-')
hold on;
plot(NormC,'g-')
%plot normalized A,B,C in a same graph
%% Challenge problems that extend the above (optional)

% 1. Write a solution to Problem 2 part 2 that doesn't use any loops at
% all. Hint: start by using the built in function bsxfun to make a matrix of all distances
% between start and stop codons. 
d

s1=strfind(d,'ATG');
t1=strfind(d,'TGA');
t2=strfind(d,'TAA');
t3=strfind(d,'TAG');
c=[t1,t2,t3];
n=sort(c);
Min=bsxfun(@minus,n,s1(:));
Minx=Min';
Minx(rem(Minx,3)~=0|Minx<=0)=inf;
ORFs=min(Minx);
ORFf=ORFs(ORFs<Inf);
disp(max(ORFf))
% 2. Problem 2, part 4. Use Matlab to compute the exact solution to this
% problem and compare your answer to what you got previously by testing
% many sequences. Plot both on the same set of axes. Hint: to get started 
% think about the following:
% A. How many sequences of length N are there?
% B. How many ways of making an ORF of length N_ORF are there?
% C. For each N_ORF how many ways of position this reading frame in a
% sequence of length N are there?

% 3. Problem 3. Assume that the error in each Cp is the standard deviation
% of the three measurements. Add a section to your code that propogates this
% uncertainty to the final results. Add error bars to your plot. (on
% propagation of error, see, for example:
% https://en.wikipedia.org/wiki/Propagation_of_uncertainty


