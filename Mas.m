function MasIm = Mas(I,avg,Up,Down)

KD = I < 0.60 *avg;
KU = I > 1.55 * avg;
I(KD) = uint8(Down);
I(KU) = uint8(Up);
MasIm =I ;
