config_file=monophone_hmm.conf

HCompV -A -D -T 1 -C $config_file -f 0.01 -m -S train.scp -M hmm0 proto
echo "~o
<STREAMINFO> 1 25
<VECSIZE> 25<NULLD><MFCC_D_N_Z_0><DIAGC>
~v varFloor1
<Variance> 25
 6.716856e-01 2.941401e-01 5.663680e-01 4.741492e-01 4.696264e-01 4.914315e-01 4.999927e-01 4.303569e-01 5.672999e-01 3.222253e-01 2.850756e-01 4.103967e-01 2.100924e-02 1.434693e-02 1.891293e-02 2.194988e-02 2.363979e-02 2.636887e-02 2.464799e-02 2.732278e-02 2.851009e-02 2.222413e-02 2.036798e-02 2.011688e-02 1.909456e-02" > hmm0/macros

for i in 1 2 3 4 5 6 7 8 9
do
	prev=$i-1
	HERest -A -D -T 1 -C $config_file -I phones0.mlf -t 250.0 150.0 1000.0 -S train.scp -H hmm$prev/macros -H hmm$prev/hmmdefs -M hmm$i monophones1
done