HLEd -A -D -T 1 -n triphones1 -l '*' -i wintri.mlf mktri.led aligned.mlf
julia mktrihed.jl monophones0 triphones1 mktri.hed
for i in 10 11 12
do
	mkdir -p hmm$i
	prev=`expr $i - 1`
	HHEd -A -D -T 1 -H hmm$prev/macros -H hmm$prev/hmmdefs -M hmm$i mktri.hed monophones0
done