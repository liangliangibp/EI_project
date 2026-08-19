import os,sys
def load_data(file_path):
    basename = os.path.basename(file_path).split('.')[0]
    output =open(basename+'.formated.bed','w')
    with open(file_path) as f:
        datalines = f.readlines()
        for line in datalines:
            line = line.strip()
            items = line.split('\t')
            gene = items[3].split('_')[-1]
            output.write('\t'.join(items[0:3])+'\t'+gene+'\t'+'\t'.join(items[6:])+'\n')

if __name__ == "__main__":

    load_data(sys.argv[1])


