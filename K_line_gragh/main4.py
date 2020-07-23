import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
from mpl_finance import candlestick_ochl
from matplotlib.pylab import date2num
#根据指定代码和时间范围，获取股票数据
df = pd.read_csv('D:/computervision/pycharm/k_line_gragh/000006.csv',usecols=['date','open','close','high','low','volume'])
#按时间升序排列数据
df.sort_values(by='date',ascending=True,inplace=True)
df=df[['date','open','close','high','low','volume']][:60]
df.date=pd.to_datetime(df.date)
#将date转化为特定的时间戳数据
df.date=df.date.apply(lambda x:date2num(x))
#将 DataFrame 转为 matrix格式
data_mat=df.as_matrix()
#设置大小，共享x坐标轴
figure,(axPrice, axVol) = plt.subplots(2, sharex=True, figsize=(15,8))
#调用方法，绘制K线图
candlestick_ochl(axPrice,data_mat,width=0.75, colorup='red', colordown='green')
axPrice.set_title("000006K线图")#设置子图标题
axPrice.legend(loc='best') #绘制图例
axPrice.set_ylabel("价格（单位：元）")
axPrice.grid(True) #带网格线
#如下绘制成交量子图
#直方图表示成交量，用for循环处理不同的颜色
for index, row in df.iterrows():
   if(row['close'] >= row['open']):
       axVol.bar(row['date'],row['volume']/1000000,width = 0.5,color='red')
   else:
       axVol.bar(row['date'],row['volume']/1000000,width = 0.5,color='green')
axVol.set_ylabel("成交量（单位：亿手）")#设置y轴标题
axVol.set_title("000006成交量子图")#设置子图的标题
xmajorLocator = MultipleLocator(5) #将x轴主刻度设置为5的倍数
axVol.xaxis.set_major_locator(xmajorLocator)
axVol.grid(True) #带网格线
#旋转x轴的展示文字角度
axPrice.xaxis_date()
plt.xticks(rotation=-40)    #将K线图x轴旋转，避免重叠
plt.tick_params(axis='x', labelsize=8)
plt.rcParams['font.sans-serif']=['SimHei']
plt.show()