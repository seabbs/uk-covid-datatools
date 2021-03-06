#' Caching and dataset management
#' @export
DataProvider = R6::R6Class("DataProvider", inherit=PassthroughFilesystemCache, 
 active=list(
   capac = function() return(self$controller$capac),
   geog = function() return(self$controller$geog),
   demog = function() return(self$controller$demog),
   codes = function() return(self$controller$codes),
   datasets = function() return(self$controller$datasets),
   spim = function() return(self$controller$spim),
   postcodes = function() return(self$controller$postcodes)
   
 ), public=list(
    controller = NULL,
    
   initialize = function(providerController, ...) {
     self$controller = providerController
     super$initialize(providerController$directory, ...)
   },
   
   downloadAndUnzip = function(id, url, pattern) {
     onsZip = paste0(self$wd,"/",id,".zip")
     unzipDir = paste0(self$wd,"/",id)
     if(!file.exists(onsZip)) {
       download.file(url, destfile = onsZip)
     } 
     if (!dir.exists(unzipDir)) {
       dir.create(unzipDir)
       unzip(onsZip, exdir=unzipDir, junkpaths = TRUE)
     }
     csvfile = paste0(unzipDir,"/",list.files(unzipDir,recursive = TRUE,pattern = pattern))
     return(csvfile)
   },
   
   downloadAndUntar = function(id, url, pattern) {
      onsZip = paste0(self$wd,"/",id,".tar.gz")
      unzipDir = paste0(self$wd,"/",id)
      if(!file.exists(onsZip)) {
         download.file(url, destfile = onsZip)
      } 
      if (!dir.exists(unzipDir)) {
         dir.create(unzipDir)
         untar(onsZip, exdir=unzipDir) #, junkpaths = TRUE)
      }
      csvfile = paste0(unzipDir,"/",list.files(unzipDir,recursive = TRUE,pattern = pattern))
      return(csvfile)
   },
   
   download = function(id, url, type="csv") {
     onsZip = paste0(self$wd,"/",id,".",type)
     if(!file.exists(onsZip)) {
       download.file(url, destfile = onsZip)
     } 
     return(onsZip)
   },
   
   downloadDaily = function(id, url, type="csv") {
     onsZip = paste0(self$todayWd,"/",id,"-",Sys.Date(),".",type)
     if(!file.exists(onsZip)) {
       download.file(url, destfile = onsZip)
     } 
     return(onsZip)
   },
   
   normaliseGender = function(gender) {
     case_when(
       is.na(gender) ~ NA_character_,
       gender %>% stringr::str_detect("f|F") ~ "female",
       gender %>% stringr::str_detect("m|M") ~ "male",
       gender %>% stringr::str_detect("u|U") ~ "unknown",
       TRUE ~ "unknown")
   },
   
   normaliseAgeCat = function(ageCat) {
      tmp_ageCat = ageCat %>% as.character() %>% stringr::str_replace(">([0-9]+)","\\1-120") %>% stringr::str_replace("<([0-9]+)","0-\\1") %>% stringr::str_replace("([0-9]+)\\+","\\1-120")
      tmp_ageCat = ifelse(is.na(tmp_ageCat) | tmp_ageCat == "0-120" | stringr::str_to_lower(tmp_ageCat)=="unknown","120-120",tmp_ageCat)
      tmp_ageMin = (tmp_ageCat %>% stringr::str_split_fixed("-",2))[,1]
      tmp_ageMax = (tmp_ageCat %>% stringr::str_split_fixed("-",2))[,2]
      tmp_rank = dense_rank(as.numeric(tmp_ageMin)*1000+as.numeric(tmp_ageMax))
      tmp_ageCat = ifelse(tmp_ageCat == "120-120","unknown",tmp_ageCat)
      tmp_ageCat = tmp_ageCat %>% stringr::str_replace("^0-","<")
      tmp_ageCat = tmp_ageCat %>% stringr::str_replace("-120$","+")
      tmp_labels = unique(tmp_ageCat[order(tmp_rank,tmp_ageCat)])
      return(factor(tmp_rank,labels=tmp_labels[!is.na(tmp_labels)]))
   },
   
   #TODO: is this the right place for this?
   cutByAge = function(age, ageBreaks = NULL) {
      # if no break specified return a column of NAs
     if(identical(ageBreaks,NULL)) return(rep(NA_character_, length(age)))
     ageLabels = self$labelsFromBreaks(ageBreaks)
     ageBreaks2 = c(-Inf,ageBreaks,Inf)
     ageCat = forcats::fct_explicit_na(
       cut(age,breaks = ageBreaks2,labels=ageLabels,ordered_result = TRUE,right=FALSE,include.lowest = TRUE),
       na_level = "unknown"
     )
     return(ageCat)
   },
   
   # convert an ageCat string into a set of breaks
   breakFromCats = function(ageCat) {
     tmp = ageCat %>% unique() %>% stringr::str_extract("[0-9]+") %>% unique() %>% as.numeric()
     return(tmp[!is.na(tmp) & tmp>0 & tmp<119])
   },
   
   labelsFromBreaks = function(ageBreaks) {
      c(
         paste0("<",ageBreaks[1]),
         paste0(ageBreaks[1:(length(ageBreaks)-1)],"-",ageBreaks[2:(length(ageBreaks))]-1),
         paste0(ageBreaks[length(ageBreaks)],"+"))
   },
   
   #' @description ordered factor from age range labels
   #' @param ageCat - a vector of age categories as strings
   #' @param ageLabels - a vector of age range labels
   
   #' @return an ordered factor of age categories
   ageCatToFactor = function(ageCat, ageLabels = c(
      "0-4","<5",
      "5-9","5-14",
      "10-14",
      "15-19","15-24",
      "20-24",
      "25-29","25-34",
      "30-34",
      "35-39","35-44",
      "40-44",
      "45-49","45-54",
      "50-54",
      "55-59","55-64",
      "60-64",
      "65-69","65-74",
      "70-74",
      "75-79","75-84",
      "80+","85+",
      "unknown"
      )) {
     factor(
       ifelse(ageCat %in% ageLabels,as.character(ageCat),"unknown"),
       levels = ageLabels,
       ordered = TRUE
     )
   },
   
   #' @description create an ordered factor of ages from a continuous age 
   #' @param age - a vector of ages
   #' @param ageLabels - a vector of age range labels
   
   #' @return an ordered factor of age categories
   ageToAgeCat = function(age, ageLabels = c("0-4","5-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74","75-79","80+")) {
     ageBreaks = c(ageLabels %>% stringr::str_extract("^[0-9]+") %>% as.integer(),Inf)
     return(cut(age,
                breaks = ageBreaks,
                labels = ageLabels,
                include.lowest = TRUE, ordered_result = TRUE
     ))
   }
   
   
 ))

