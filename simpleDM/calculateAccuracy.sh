
echo "=========="
echo "CLOSED SET"
echo "=========="
echo "" > wavlst
for entry in ../set_2/*/*01.wav
do
	echo $entry >>wavlst
done
julius -input rawfile -filelist wavlst -smpFreq 16000  -C simpleDM.jconf > juliusOutput

bash PreprocessJuliusOutput.sh
./ProcessJuliusOutput.pl juliusOutput juliusProcessed
HResults -I ../words.mlf ../monophones1 juliusProcessed

echo "=========="
echo "OPEN SET"
echo "=========="
echo "" > wavlst
for entry in ../open_set/*v
do
	echo $entry >>wavlst
done
cat wavlst
julius -input rawfile -filelist wavlst -smpFreq 44100  -C simpleDM.jconf > juliusOutput

bash PreprocessJuliusOutput.sh
./ProcessJuliusOutput.pl juliusOutput juliusProcessedOpen
HResults -I ../open_set/transcript.mlf ../monophones1 juliusProcessedOpen
