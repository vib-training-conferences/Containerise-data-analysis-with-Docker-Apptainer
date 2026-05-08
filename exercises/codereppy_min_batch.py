#Packages required 

import numpy as np # linear algebra
import matplotlib.pyplot as plt
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import RobustScaler #for robust feature scaling
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay, classification_report, accuracy_score, roc_curve, auc
from scipy import stats # Hypthesis testing 
import seaborn as sns
# add in special sauce to use our python files containing useful functions
import plots as pe
import models as mods
import html_gen as hg

# Read and characterise data
data_df = pd.read_csv("datasets/data.csv")

data_df.head().T

hg.start_html() # start creating web page

data_df.diagnosis = data_df.diagnosis.apply(lambda x: 1 if x == 'M' else 0)

data_df.shape
data_df.columns
data_df = data_df.dropna(axis = 1)

B, M = data_df.diagnosis.value_counts()
xtickmarks = ['B', 'M']

outp = 'Number of Malignant tumours: ' + str(M) +'\n'
outp = outp + 'Number of Benign tumours   : ' + str(B) + '\n'

hg.html_para(outp)
pe.createCountplot(data_df, xtickmarks)

hg.html_img("Countplot", "coderep_countplot.png")

# Finish up the web page
hg.end_html()
