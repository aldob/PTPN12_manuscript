import pandas as pd
import os
import multiprocess as mp

def translocount_pipe(file):
    import pandas as pd

    strucdict = dict()
    sample = file.split(".")[0]
    with open(file) as sprofile:
        header = sprofile.readline()
        rc = float(header.strip().split("=")[-1]) # Alignment readcount for normalisation 
        for line in sprofile:
            cols = line.strip().split("\t")
            mut = cols[-1]
            if mut not in strucdict:
                strucdict[mut] = 1
            else:
                strucdict[mut]+=1

    for k,v in strucdict.items():
        strucdict[k] = [1000000*v/rc] # per million

    df = pd.DataFrame.from_records(strucdict)
    df['sample'] = sample
    return(df)

def insertlen_pipe(file):
    import pandas as pd
    sample = file.split(".")[0][:-5]
    lendict = dict()
    with open(file) as lenfil:
        for line in lenfil:
            rounded = round(int(line.strip())-5, -1) # round to nearest 10
            if rounded in lendict:
                lendict[rounded]+=1
            else:
                lendict[rounded]=1
    lensdf = pd.DataFrame.from_dict(lendict, orient='index', columns=[sample]).sort_index()
    return(lensdf)



files = [file for file in os.listdir() if file.endswith("sprofile")]
with mp.Pool(10) as pool:
    results = pool.map(translocount_pipe, files)
rearrdf = pd.concat([res for res in results])
rearrdf.to_csv("rearrangement_percs.csv", index=False)


files = [file for file in os.listdir() if file.endswith("lens.txt")]
with mp.Pool(10) as pool:
    results = pool.map(insertlen_pipe, files)
lenstables = pd.concat([res for res in results], axis=1)
lenstables.to_csv("lens_table.csv")




