
# coding: utf-8
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

with open('output_H.xyz', encoding='utf-8')as f:
    num = 0
    cols=[]
    H_models=[]
    for i,row in enumerate(f):
        if i%234 == 0 or i%234 == 1:
            continue
        col = row.rstrip().split(' ')
        cols.append(col)
        if i%234 == 233:
            num +=1
            H_models.append(cols)
            cols=[]

with open('output_I.xyz', encoding='utf-8')as f:
    num = 0
    cols=[]
    I_models=[]
    for i,row in enumerate(f):
        if i%234 == 0 or i%234 == 1:
            continue
        col = row.rstrip().split(' ')
        cols.append(col)
        if i%234 == 233:
            num +=1
            I_models.append(cols)
            cols=[]

with open('output_N.xyz', encoding='utf-8')as f:
    num = 0
    cols=[]
    N_models=[]
    for i,row in enumerate(f):
        if i%234 == 0 or i%234 == 1:
            continue
        col = row.rstrip().split(' ')
        cols.append(col)
        if i%234 == 233:
            num +=1
            N_models.append(cols)
            cols=[]

def make_xyz_by_time(models,name):
    for i,model in enumerate(models):
        df_xyz = pd.DataFrame(model)
        df_xyz.columns = ['atom', 'x', 'y', 'z']
        df_xyz['Time (ps)'] = 0
        df_xyzs = df_xyz
        if i >= 0:
            break
    for i,model in enumerate(models[1:]):
        df_xyz = pd.DataFrame(model)
        df_xyz.columns = ['atom', 'x', 'y', 'z']
        time_value = i*0.5*10**(-3)
        df_xyz['Time (ps)'] = time_value
        df_xyzs = pd.concat([df_xyzs,df_xyz])
    df_PTCDI_xyz = df_xyzs.apply(pd.to_numeric, errors='ignore')
    df_PTCDI_xyz.to_csv(name + '_xyz.csv')

make_xyz_by_time(H_models,'H')
make_xyz_by_time(I_models,'I')
make_xyz_by_time(I_models,'N')
