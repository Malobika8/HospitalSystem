import requests as req
from bs4 import BeautifulSoup
import pandas as pd

r = req.get('https://azure.microsoft.com/en-in/pricing/details/managed-disks/')

# print(r)
# print(r.content)

soup = BeautifulSoup(r.content, 'lxml')
table1 = soup.find('table', class_='data-table__table')
# print(table1)
headers = []
for i in table1.find_all('th'):
    title = i.text
    headers.append(title)

headers[0] = 'Disk Name'

myData = pd.DataFrame(columns = headers)

for j in table1.find_all('tr')[1:]:
    row_data = j.find_all('td')
    row = [i.text for i in row_data]
    length = len(myData)
    myData.loc[length] = row

# myData.to_csv('Azure_Disk_Pricing.csv')
print(myData)