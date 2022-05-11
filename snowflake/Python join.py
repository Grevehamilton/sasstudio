/*some documentation*/
import pandas as pd
snowclass = SAS.sd2df('mysnow.class') 
snowclassfit = SAS.sd2df('mysnow.classfit')
/*En beskrivning*/
inner_join_df= pd.merge(snowclass, snowclassfit, on='Name', how='inner')

snowclassjoin = SAS.df2sd(inner_join_df, 'work.snowclassjoin')