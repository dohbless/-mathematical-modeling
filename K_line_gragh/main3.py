import pandas as pd
import os
import matplotlib.pyplot as plt
import pandas as pd
HOUSING_PATH="D:\\computervision\\pycharm\\k_line_gragh"
#导入数据
def load_housing_data(housing_path=HOUSING_PATH):
    csv_path=os.path.join(housing_path,"000008.csv")
    return pd.read_csv(csv_path)
housing=load_housing_data()
#绘制直方图
housing.hist(bins=50,figsize=(20,15))#bins总个数，figsize图的大小
plt.show()
