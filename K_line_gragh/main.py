import matplotlib.pyplot as plt
import mpl_finance as mpf
import numpy as np
import pandas as pd
from matplotlib.pylab import date2num

data=pd.read_csv('D:\\computervision\\pycharm\\k_line_gragh\\000008.csv',usecols=['date','open','close','high','low','volume','amount'])

#删除空行
data[data['volume']==0]=np.nan
data=data.dropna()

#按时间升序排列数据
data.sort_values(by='date',ascending=True,inplace=True)
data=data[['date','open','close','high','low','volume','amount']][:60]#这里由于数据太多，仅取前3000行进行绘制

data.date=pd.to_datetime(data.date)
#将date转化为特定的时间戳数据
data.date=data.date.apply(lambda x:date2num(x))

#将 DataFrame 转为 matrix格式
data_mat=data.as_matrix()

#绘制图片
fig,ax=plt.subplots(figsize=(2000/72,480/72))
fig.subplots_adjust(bottom=0.1)
plt.title("000008")
plt.xticks(rotation=-40)    #将K线图x轴旋转，避免重叠
plt.tick_params(axis='x', labelsize=8)
mpf.candlestick_ochl(ax,data_mat,colordown='#53c156', colorup='#ff1717',width=0.3,alpha=1)
ax.grid(True)
ax.xaxis_date()
plt.tight_layout()

plt.show()
plt.savefig("K线.png")## 保存图片
plt.close() ## 关闭plt，释放内存
