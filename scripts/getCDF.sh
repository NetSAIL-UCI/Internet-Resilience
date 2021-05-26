sort $1/$2.txt > $1/$2-sorted.txt
cat $1/$2-sorted.txt | awk '{a[$1]+=1}END{for (key in a){print key, a[key]}}' > temp.txt
sort -nk1 temp.txt > $1/$2-sorted.txt
awk 'FNR==NR{sum+=$2; prev=0; next;}{if(FNR==1){print $0, prev;} curr+=$2; cdf=curr/sum; print $0, cdf; prev = cdf; }' $1/$2-sorted.txt $1/$2-sorted.txt > $1/$2-cdf.txt   
rm $1/$2-sorted.txt
