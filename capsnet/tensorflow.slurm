#source activate
python capsnetv2.py --epochs 50 --batch_size 32 --routings 4
python capsnetv3.py --testing  --weights "/pylon5/at560kp/achatto2/Tensorflow/Clustering/ExtremeEvents/after_James/winter_capsnet/prediction/leadday1/result/weights-07.h5"
