#source activate
python capsnetv2.py --epochs 50 --batch_size 32 --routings 4
python capsnetv3.py --testing  --weights "/result/weights-07.h5"
