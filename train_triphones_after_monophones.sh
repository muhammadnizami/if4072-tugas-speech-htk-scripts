HLEd -A -D -T 1 -n triphones1 -l '*' -i wintri.mlf mktri.led aligned.mlf
julia mktrihed.jl monophones0 triphones1 mktri.hed
for i in 10 11 12
do
	mkdir -p hmm$i
	prev=`expr $i - 1`
	HHEd -A -D -T 1 -H hmm$prev/macros -H hmm$prev/hmmdefs -M hmm$i mktri.hed monophones0
done

HDMan -A -D -T 1 -b sp -n fulllist0 -g maketriphones.ded -l flog dict-tri output_sorted_cut.txt
julia fixfulllist.jl fulllist0 monophones0 fulllist

julia mkclscript.jl monophones0 tree.hed

mkdir -p 13
HHEd -A -D -T 1 -H hmm12/macros -H hmm12/hmmdefs -M hmm13 tree.hed triphones1 
mkdir -p hmm14
HERest -A -D -T 1 -T 1 -C monophone_hmm.conf -I wintri.mlf  -t 250.0 150.0 3000.0 -S train.scp -H hmm13/macros -H hmm13/hmmdefs -M hmm14 tiedlist
mkdir -p hmm15
HERest -A -D -T 1 -T 1 -C monophone_hmm.conf -I wintri.mlf  -t 250.0 150.0 3000.0 -S train.scp -H hmm14/macros -H hmm14/hmmdefs -M hmm15 tiedlist


