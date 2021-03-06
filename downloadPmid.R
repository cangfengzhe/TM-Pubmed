#data.frame
library(XML)

downloadPmid<-function(str){


  #prestr=paste(c(str,' [MeSH Terms] OR ',str,'[Title/Abstract]'),collapse='')
  prestr<-str
  preurl<-paste(c('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=',prestr),collapse='')
  prexmlfile<-htmlParse(preurl,encoding="UTF-8",asTree = TRUE)#??ȡhtml?ļ?
  countNode<-getNodeSet(prexmlfile,"//count");
  pmidCount<-sapply(countNode, xmlValue)
  pmidCount<-as.data.frame(pmidCount,stringsAsFactors = FALSE)
  as.numeric(pmidCount[1,1])->retMax;
  if(retMax==0){
    Pmid=NA
    return(Pmid)
  }
  if(retMax<=20 &  retMax!=0){
    nodeName<-getNodeSet(prexmlfile,"//id");# get the node and attribute
    Pmid<-sapply(nodeName,xmlValue) #get the attribute
    
    
    return(Pmid) 
  }
  
  if(retMax>20) {
  url<-paste(c('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=',prestr,'&RetMax=',retMax),collapse='')
  
  xmlfile<-htmlParse(url,encoding="UTF-8",asTree = TRUE)#
  nodeName<-getNodeSet(xmlfile,"//id");# get the node and attribute
  Pmid<-sapply(nodeName, xmlValue) #get the attribute
 

 return(Pmid) 
  }
  
}

#  url<-paste(c('http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=',str,'&RetMax=',retMax,'&RetStart=',retStart),collapse='')

