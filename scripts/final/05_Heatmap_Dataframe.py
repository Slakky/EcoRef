import pandas as pd
import numpy as np; np.random.seed(0)
import seaborn as sns; sns.set()
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.ticker as tkr
from scipy.stats import binned_statistic

bin_size = 1000

df = pd.read_table('/home/claudio/nas/output/all_env.plot', sep = '\t')
all_df = df.drop(df.columns[[1,2,5,6,7,8]], axis = 1)
conditions = sorted(list(set(all_df['COND'])))
bin_list = [i for i in range(0, max(all_df['BP']), bin_size)]


d = {}
for condition in conditions:
    d.setdefault(condition, {})
    cond_df = all_df[all_df['COND'] == condition]
    statistic, edges, bin_nr = binned_statistic(cond_df['BP'], cond_df['P'], min, bin_list)
    # bins = [(i,k) for i,k in zip(edges, edges[1:])] not a good idea to have tuples as column names in pandas
    bins = [i for i,k in enumerate(edges)]
    pval_bin = zip(statistic,bins)
    for i,k in pval_bin:
        if np.isnan(i):
            i = 1
        d[condition][k] = i

df = pd.DataFrame(d).transpose().apply(lambda x: -(np.log10(x)), axis = 1)

df.to_csv('/home/claudio/nas/output/heatmap_dataframe.tsv', sep = '\t', index = False)
