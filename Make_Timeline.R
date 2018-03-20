#Поисковая система http://www.rambler.ru
library('XML')                 
library('RCurl')

DataFr <- data.frame()
#цикл с диапазоном рассматриваемых лет
for(i in 2005:2015){
  a <- c()
  b <- c()
  e <- c()
  
  #три вида запросов в цикле for
  fileURL[1] <-paste0("https://nova.rambler.ru/search?query=%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D0%B8%20nissan%20%D0%BA%20",i,"")
  fileURL[2] <-paste0("https://nova.rambler.ru/search?query=%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D0%B8%20nissan%20%D0%BD%D0%B0%20",i,"")
  fileURL[3] <-paste0("https://nova.rambler.ru/search?query=%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D0%B8%20nissan%20%D0%BF%D0%BE%D1%81%D0%BB%D0%B5%20",i,"")
  
    for(m in 1:3){
    html <- getURL(fileURL[m])
    doc <- htmlTreeParse(html, useInternalNodes = T)
    rootNode <- xmlRoot(doc)
    #выбираем все заголовки результатов запроса 
    title <- xpathSApply(rootNode, '//a[contains(@class, " ac-algo fz-l ac-21th lh-24")]', xmlValue)
    a <- c(a,title)
    
    #находим полную ссылку на источник
    url <- xpathSApply(rootNode,'//a[contains(@class, " ac-algo fz-l ac-21th lh-24")]', xmlGetAttr, 'href')
    
    e <- c(e, url)
    #находим источник новости, который виден на странице выдачи поисковика
    Source <- xpathSApply(rootNode,'//span[contains(@class, "fz-ms")]', xmlValue)
    b <- c(b,Source) 
    
    Sys.sleep(0.1);
  }
  
  #объединяем полученные данные 
  DF.news <- data.frame(
    Year = i,
    Header = a,
    Source = new_b,
    Url = e,
    stringsAsFactors = F)
  
  DataFr <- rbind(DataFr, DF.news)
  Sys.sleep(0.1);
}
#сохраняем данные в .csv
file_out <- './Timeline.csv'
write.csv(DataFr, file = file_out, row.names = F)
