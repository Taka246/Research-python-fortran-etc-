
# coding: utf-8

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler

def unit(x): #単位ベクトル化
        return x/np.linalg.norm(x)

def angle(nx,ny): #単位ベクトル間の角度算出
    return np.arccos(np.dot(nx, ny.T)) * 180 / np.pi

def I_or_N(xyz):
    xyz.insert(1,'weight',xyz['atom'].replace('H',1.008).replace('C',12.01).replace('N',14.01).replace('O',16))
    xyz['distance'] = ((xyz['x'] - xyz['x2'])**2 + (xyz['y'] - xyz['y2'])**2 + (xyz['z'] - xyz['z2'])**2)**0.5
    distance_m = np.mean(xyz['distance']) #分子間距離平均

    r_g1 = np.dot(([xyz['x'],xyz['y'],xyz['z']]),xyz['weight'])/sum(xyz['weight'])
    r_g2 = np.dot(([xyz['x2'],xyz['y2'],xyz['z2']]),xyz['weight'])/sum(xyz['weight'])
    distance_g = np.linalg.norm(r_g1-r_g2) #羽重心間距離


    N_vec = xyz.ix[xyz['atom'] == 'N', 2:8]
    wing_right1 = unit(N_vec.iloc[0:1,:3] - N_vec.iloc[1,:3].values) #(I or N_dimer '中心'ー'羽'　29-24,71-66)
    wing_left1 = unit(N_vec.iloc[2:3,:3] - N_vec.iloc[3,:3].values)
    wing_right2 = unit(N_vec.iloc[0:1,3:] - N_vec.iloc[1,3:].values)
    wing_left2 = unit(N_vec.iloc[2:3,3:] - N_vec.iloc[3,3:].values)

    wing1 = (N_vec.iloc[1,:3].values + N_vec.iloc[3,:3].values)/2 #羽根元間距離byモノマー
    wing2 = (N_vec.iloc[1,3:].values + N_vec.iloc[3,3:].values)/2
    distance_w = np.linalg.norm(wing1-wing2)

    theta1 = angle(wing_right1,wing_left1) #羽の角度算出
    theta2 = angle(wing_right2,wing_left2)
    wing_1 = unit(wing_right1 + wing_left1.values) #羽の合成単位ベクトル
    wing_2 = unit(wing_right2 + wing_left2.values)
    n1 = unit(np.cross(wing_right1,wing_left1)) #外積　羽に対する法線単位ベクトル
    n2 = unit(np.cross(wing_right2,wing_left2))
    theta_n = angle(n1,n2) #羽法線ベクトル同士の角度　＝　羽平面同士の角度
    theta_w = angle(wing_1,wing_2) #羽合成ベクトル同士の角度
    output_values = np.round([distance_m,distance_g,theta1,theta2,theta_n,theta_w,distance_w],2)
    return output_values

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

dimer_id = []
distance_m = []
distance_g = []
theta1 = []
theta2 = []
theta_n = []
theta_w = []
time = []
distance_w = []
for i,model in enumerate(I_models):
    df_xyz = pd.DataFrame(model)
    df_xyz.columns = ['atom', 'x', 'y', 'z']
    xyz_m1 = df_xyz.iloc[:116,:]
    xyz_m2 = df_xyz.iloc[116:,1:4].reset_index()
    del xyz_m2['index']
    xyz = xyz_m1.assign(x2= xyz_m2['x'],y2= xyz_m2['y'],z2= xyz_m2['z']).apply(pd.to_numeric, errors='ignore')
    ptcdi = I_or_N(xyz)
    dimer_id.append('I')
    distance_m.append(ptcdi[0])
    distance_g.append(ptcdi[1])
    theta1.append(ptcdi[2])
    theta2.append(ptcdi[3])
    theta_n.append(ptcdi[4])
    theta_w.append(ptcdi[5])
    time_value = np.round(i*0.5*200*10**(-3),1)
    time.append(time_value)
    distance_w.append(ptcdi[6])

data_I = pd.DataFrame([dimer_id, time, distance_m, distance_g, distance_w, theta1, theta2, theta_n, theta_w]).T
data_I.columns = ['Dimer ID', 'Time (ps)', 'Mean Distance', 'Centroid Distance', 'Distance of Wing Roots', 'Angle of Wing1', 'Angle of Wing2', 'Theta_n', 'Theta_w']

df_PTCDI_I = data_I.apply(pd.to_numeric, errors='ignore')
df_PTCDI_I.to_csv('I_PTCDI.csv')
