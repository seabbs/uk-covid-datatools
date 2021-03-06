

#' Calculates a survival R(t) curve on grouped data
#' 
#' N.B. EpiEstim has a bug affecting 0.25 quantiles which is being looked at
#' 
#' @param groupedDf - a df which may be grouped, of timeseries data including an incidence column with continuous positive non NA values. 
#' @param config An object of class estimate_R_config, as returned by function EpiEstim::make_config.
#' @param dateVar - the variable containing the seqence of dates
#' @param incidenceVar - the sequence of daily incidence
#' @param window - the width of the smoothing function applied (default 2)
#' @return a dataframe with groupwise Rt estimates
#' @import dplyr

tidyEstimateRt = function(groupedDf, config, dateVar = "date", incidenceVar = "incidence",  method="uncertain_si", window=2,...) {
  grps = groups(groupedDf)
  dateVar = ensym(dateVar)
  incidenceVar = ensym(incidenceVar)
  joinBy = joinList(groupedDf, defaultJoin = as_label(dateVar))
  
  groupedDf = groupedDf %>% filter(!is.na(!!incidenceVar)) %>% mutate(check = !!incidenceVar>=0)
  if (any(groupedDf$check==FALSE)) {
    message("Negative daily incidence in...",print_and_capture(groupedDf %>% filter(check==FALSE)))
    stop()
  }
  tmp = groupedDf %>% select(!!!grps, dates = !!dateVar,I=!!incidenceVar) 
  # tmp starts on first non zero value of I in group
  tmp2 = tmp %>% group_modify(function(d,g) {
    siConfig = config
    if(nrow(d) >= 2+window) {
      d = d %>% arrange(dates) %>% mutate(seq_id=row_number())
      siConfig$t_start = c(2:(nrow(d)-window))
      siConfig$t_end = siConfig$t_start+window
      tmp4 = suppressWarnings(EpiEstim::estimate_R(d,method = method,config=siConfig,...))
      tmp5 = tmp4$R %>% mutate(seq_id=t_end)
      tmp6 = d %>% left_join(tmp5, by="seq_id")
      #browser()
      return(tmp6 %>% select(-seq_id))
    } else {
      # not enough data
      return(d %>% mutate(
        t_start = NA,
        t_end = NA,
        `Mean(R)` = NA,                    
        `Std(R)` = NA,
        `Quantile.0.025(R)` = NA,
        `Quantile.0.05(R)` = NA,
        `Quantile.0.25(R)` = NA,
        `Median(R)` = NA,
        `Quantile.0.75(R)` = NA,
        `Quantile.0.95(R)` = NA,
        `Quantile.0.975(R)` = NA
      ))
    }
  }) %>% rename(!!dateVar := dates)
  return(groupedDf %>% left_join(tmp2, by=joinBy) %>% select(-I,-t_start,-t_end,-check))
}

#' Get UK outbreak timeseries data
#' 
#' data held in google sheets:
#' https://docs.google.com/spreadsheets/d/1snb-vYuH7fVpTuyoQrM8zWiABYoXbSrnn44w-zlhM90/edit?usp=sharing
#' 
#' @import dplyr
#' @return a data frame with several timeseries in it

getUKCovidTimeseries = function() {
  
  #TODO: convert to use:
  # https://github.com/tomwhite/covid-19-uk-data/raw/master/data/covid-19-cases-uk.csv
  # https://github.com/tomwhite/covid-19-uk-data/raw/master/data/covid-19-indicators-uk.csv
  # cases by region:
  # https://coronavirus.data.gov.uk/#
  
  # in the beginning wales reported by UA then shifted to Health board
  walesUAtoHealthBoard = readr::read_csv("https://opendata.arcgis.com/datasets/680c9b730655473787cb594f328a86fa_0.csv")
  
  covid_19_cases_uk <- read_csv("https://github.com/tomwhite/covid-19-uk-data/raw/master/data/covid-19-cases-uk.csv", 
                                col_types = cols(Date = col_date(format = "%Y-%m-%d")), 
                                na = c("","NaN","NA")
  )
  covid_19_cases_uk = covid_19_cases_uk %>% filter(Date>as.Date("2020-03-06")) %>% mutate(TotalCases = as.numeric(TotalCases))
  tmp = covid_19_cases_uk %>% rename(code = AreaCode, name = Area, date = Date, cumulative_cases=TotalCases)
  tmp = tmp %>% left_join(walesUAtoHealthBoard, by=c("code"="UA19CD"))
  tmp = tmp %>% 
    mutate(
      code = if_else(is.na(LHB19CD),code,LHB19CD),
      name = if_else(is.na(LHB19NM),name,LHB19NM)
    ) %>% 
    group_by(code,date) %>% 
    summarise(cumulative_cases = sum(cumulative_cases, na.rm=TRUE)) %>% 
    filter(!is.na(code)) %>% 
    ungroup() %>%
    left_join(
      tmp %>% group_by(code) %>% summarise(name = min(name)), by="code"
    )
  non_england_uk = tmp %>% mutate(country = case_when(
    stringr::str_starts(code,"S") ~ "Scotland",
    stringr::str_starts(code,"W") ~ "Wales",
    stringr::str_starts(code,"E") ~ "England",
    stringr::str_starts(code,"N") ~ "Northern Ireland"
  )) %>% filter(country != "England")
  
  #browser()
  
  covid_19_indicators_uk <- read_csv("https://github.com/tomwhite/covid-19-uk-data/raw/master/data/covid-19-indicators-uk.csv", 
                                     col_types = cols(Date = col_date(format = "%Y-%m-%d")))
  
  country_totals = covid_19_indicators_uk %>% pivot_wider(names_from = Indicator, values_from = Value) 
  country_totals = country_totals %>% expand(Date,Country) %>% left_join(country_totals, by=c("Date","Country"))
  
  tmp = country_totals %>% group_by(Date) %>% mutate(
    missingTests = sum(ifelse(Country=="UK",1,-1)*Tests,na.rm=TRUE),
    missingCases = sum(ifelse(Country=="UK",1,-1)*ConfirmedCases,na.rm=TRUE),
    missingDeaths = sum(ifelse(Country=="UK",1,-1)*Deaths,na.rm=TRUE)
  )
  
  country_totals = tmp %>% mutate(
    Tests = ifelse(Country == "England" & missingTests > 0, missingTests, Tests)
  ) %>% filter(Date > as.Date("2020-03-05")) %>% select(-missingCases,-missingTests,-missingDeaths) %>%
    rename(date=Date,country=Country, cumulative_cases=ConfirmedCases,cumulative_tested=Tests,cumulative_deaths=Deaths)
  
  uk_totals_including_private = country_totals %>% filter(country == "UK")
  country_totals = country_totals %>% filter(country != "UK")
  
  ph_cases = read_csv("https://coronavirus.data.gov.uk/downloads/csv/coronavirus-cases_latest.csv", 
                      col_types = cols(`Specimen date` = col_date(format = "%Y-%m-%d")))
  ph_cases_2 = ph_cases %>% select(date = `Specimen date`, code = `Area code`, name=`Area name`,cumulative_cases = `Cumulative lab-confirmed cases`, type=`Area type`)
  
  #country_totals = ph_cases_2 %>% filter(type == "Nation") %>% select(-type)
  phe_region = ph_cases_2 %>% filter(type == "Region") %>% select(-type)
  
  nhs_region = ph_cases_2 %>% filter(type == "Region") %>% 
    select(-type) %>% inner_join(PHE_region_to_NHS_region, by=c("code"="PHEC_code")) %>% 
    select(-code,-name) %>% rename(code = NHSER_code, name = NHSER_name) %>% 
    group_by(code,name,date) %>% summarise(cumulative_cases = sum(cumulative_cases))

  
    
  england_utla = ph_cases_2 %>% filter(type == "Upper tier local authority") %>% select(-type)
  england_ltla = ph_cases_2 %>% filter(type == "Lower tier local authority") %>% select(-type)
  
  
  combinedUK = non_england_uk %>% rbind(england_utla %>% mutate(country="England"))
  combinedUK_LTLA = non_england_uk %>% rbind(england_ltla %>% mutate(country="England"))
  
  tidyCombinedUK = combinedUK %>% 
    left_join(country_totals %>% rename(daily_total = cumulative_cases) %>% select(-cumulative_tested, -cumulative_deaths), by = c("date","country")) %>% 
    group_by(date,country) %>% 
    mutate(daily_unknown = daily_total-sum(cumulative_cases))
  
  browser()
  
  tidyCombinedUK_LTLA = combinedUK_LTLA %>% 
    left_join(country_totals %>% rename(daily_total = cumulative_cases) %>% select(-cumulative_tested, -cumulative_deaths), by = c("date","country")) %>% 
    group_by(date,country) %>% 
    mutate(daily_unknown = daily_total-sum(cumulative_cases))
  
  
  
  # UKregional=readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=163112336&single=true&output=csv", 
  #                   col_types = readr::cols(date = readr::col_date(format = "%Y-%m-%d")))
  # 
  # englandNHS=readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=0&single=true&output=csv", 
  #                     col_types = readr::cols(date = readr::col_date(format = "%Y-%m-%d")))
  # 
  # scotlandHealthBoard = readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=490497042&single=true&output=csv")
  # walesHealthBoard = readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=762770891&single=true&output=csv")
  # northernIreland = readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=1217212942&single=true&output=csv")
  # englandUnitAuth=readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=796246456&single=true&output=csv")
  
  englandUnitAuth2NHSregion=readr::read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQod-HdDk4Nl8BFcunG5P-QA2CuKdIXCfK53HJDxcsaYlOov4FFc-yQciJyQFrqX5_n_ixz56S7uNBh/pub?gid=1933702254&single=true&output=csv")
  # 
  # tidyEnglandNHS = tidyCombinedUK %>% inner_join(englandUnitAuth2NHSregion, by=c("code"="GSS_CD")) %>% group_by(date,Region) %>% summarise(
  #   cumulative_cases = sum(cumulative_cases),
  #   daily_total = first(daily_total),
  #   daily_unknown = first(daily_unknown)
  # ) %>% rename(england_nhs_region = Region)
  # 
  
  tidyEnglandPHE = phe_region %>% 
    left_join(country_totals %>% filter(country=="England") %>% rename(daily_total = cumulative_cases) %>% select(-cumulative_tested, -cumulative_deaths), by = c("date")) %>% 
    group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases), england_phe_region = name)
  
  tidyEnglandNHS = nhs_region %>% 
    left_join(country_totals %>% filter(country=="England") %>% rename(daily_total = cumulative_cases) %>% select(-cumulative_tested, -cumulative_deaths), by = c("date")) %>% 
    group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases), england_nhs_region = name)
  
  
  tidyEnglandNHS = tidyCombinedUK %>% inner_join(englandUnitAuth2NHSregion, by=c("code"="GSS_CD")) %>% group_by(date,Region) %>% summarise(
    cumulative_cases = sum(cumulative_cases),
    daily_total = first(daily_total),
    daily_unknown = first(daily_unknown)
  ) %>% rename(england_nhs_region = Region)
  
  
  # tidy England unitary authority region
  # tmp = englandUnitAuth %>% 
  #   tidyr::pivot_longer(cols=starts_with("20"),names_to = "date",values_to = "cumulative_cases", values_ptypes = list(cumulative_cases=integer())) %>%
  #   mutate(date = as.Date(as.character(date),"%Y-%m-%d"))
  # tmp = tmp %>% left_join(UKregional %>% select(date,daily_total=england_cumulative_cases), by="date")
  # tidyEnglandUnitAuth = tmp %>% group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases,na.rm = TRUE)) %>%
  #   ungroup() %>% group_by(CTYUA19CD, CTYUA19NM)
  
  # tidy Scotland health board
  # tmp = scotlandHealthBoard %>% 
  #   tidyr::pivot_longer(cols=starts_with("20"),names_to = "date",values_to = "cumulative_cases", values_ptypes = list(cumulative_cases=integer())) %>%
  #   mutate(date = as.Date(as.character(date),"%Y-%m-%d"))
  # tmp = tmp %>% left_join(UKregional %>% select(date,daily_total=scotland_cumulative_cases), by="date")
  # tidyScotlandHealthBoard = tmp %>% group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases,na.rm = TRUE)) %>%
  #   ungroup() %>% group_by(HB16CD, HB16NM)
  
  # tidy Wales health board
  # tmp = walesHealthBoard %>% 
  #   tidyr::pivot_longer(cols=starts_with("20"),names_to = "date",values_to = "cumulative_cases", values_ptypes = list(cumulative_cases=integer())) %>%
  #   mutate(date = as.Date(as.character(date),"%Y-%m-%d"))
  # tmp = tmp %>% left_join(UKregional %>% select(date,daily_total=wales_cumulative_cases), by="date")
  # tidyWalesHealthBoard = tmp %>% group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases,na.rm = TRUE)) %>%
  #   ungroup() %>% group_by(LHB16CD, LHB16NM)
  # 
  # # tidy Wales health board
  # tmp = northernIreland %>% 
  #   tidyr::pivot_longer(cols=starts_with("20"),names_to = "date",values_to = "cumulative_cases", values_ptypes = list(cumulative_cases=integer())) %>%
  #   mutate(date = as.Date(as.character(date),"%Y-%m-%d"))
  # tmp = tmp %>% left_join(UKregional %>% select(date,daily_total=northern_ireland_cumulative_cases), by="date")
  # tidyNorthernIreland = tmp %>% group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases,na.rm = TRUE)) %>%
  #   ungroup() %>% group_by(LGD14CD, LGD14NM)
  # 
  # # combined regional
  # tidyCombinedUK = bind_rows(
  #   tidyEnglandUnitAuth %>% rename(code=CTYUA19CD, name=CTYUA19NM),
  #   tidyScotlandHealthBoard %>% rename(code=HB16CD, name=HB16NM),
  #   tidyWalesHealthBoard %>% rename(code=LHB16CD, name=LHB16NM)#,
  #   #tidyNorthernIreland %>% rename(code=LGD14CD, name=LGD14NM)
  # )
  # 
  # # tidy England NHS region
  # tmp = englandNHS %>% tidyr::pivot_longer(cols=!date,names_to = "england_nhs_region",values_to = "cumulative_cases", values_ptypes = list(cumulative_cases=integer()))
  # tmp = tmp %>% left_join(UKregional %>% select(date,daily_total=england_cumulative_cases), by="date")
  # tidyEnglandNHS = tmp %>% group_by(date) %>% mutate(daily_unknown = daily_total-sum(cumulative_cases,na.rm = TRUE)) %>%
  #   ungroup() %>% group_by(england_nhs_region)
  
  # tidy UK regional
  # tidyUKRegional = UKregional %>% select(date,england_cumulative_cases,scotland_cumulative_cases,wales_cumulative_cases,northern_ireland_cumulative_cases,daily_total=uk_cumulative_cases) %>% 
  #   tidyr::pivot_longer(cols=ends_with("cumulative_cases"),names_to = "uk_region",values_to = "cumulative_cases", values_ptypes = list(cumulative_cases=integer())) %>%
  #   filter(!is.na(cumulative_cases)) %>%
  #   mutate(uk_region = stringr::str_remove(uk_region,"_cumulative_cases")) %>%
  #   mutate(uk_region = stringr::str_replace(uk_region,"_"," "))  %>% 
  #   group_by(date) %>% 
  #   mutate(daily_unknown = daily_total-sum(cumulative_cases,na.rm = TRUE)) %>%
  #   ungroup() %>% group_by(uk_region)
  # 
  
  tidyUKRegional = country_totals %>% rename(uk_region = country) %>%
    group_by(uk_region) %>% arrange(date) %>% mutate(
      # daily_cases = cumulative_cases-lag(cumulative_cases, default=0),
      # daily_deaths = cumulative_deaths-lag(cumulative_deaths, default=0),
      daily_tested = cumulative_tested-lag(cumulative_tested, default=0)
    )
  
  tidyUK = country_totals %>% group_by(date) %>%
    summarise(
      cumulative_cases = sum(cumulative_cases),
      cumulative_deaths = sum(cumulative_deaths),
      cumulative_tested = sum(cumulative_tested)
    ) %>% arrange(date) %>% mutate(
      # daily_cases = cumulative_cases-lag(cumulative_cases, default=0),
      # daily_deaths = cumulative_deaths-lag(cumulative_deaths, default=0),
      daily_tested = cumulative_tested-lag(cumulative_tested, default=0)
    ) %>% left_join(uk_totals_including_private %>% rename(
      cumulative_cases_from_tracker = cumulative_cases,
      cumulative_tested_from_tracker = cumulative_tested,
      cumulative_deaths_from_tracker = cumulative_deaths
    ) %>% select(-country), by="date")

  return(list(
    # UKregional=UKregional,
    # englandNHS=englandNHS,
    # englandUnitAuth=englandUnitAuth,
    # scotlandHealthBoard=scotlandHealthBoard,
    # walesHealthBoard=walesHealthBoard,
    # northernIrelandLocalGovernmentDistrict=northernIreland,
    # englandUnitAuth2NHSregion=englandUnitAuth2NHSregion,
    tidyUK=tidyUK,
    tidyUKRegional=tidyUKRegional,
    tidyEnglandNHS=tidyEnglandNHS,
    tidyEnglandPHE=tidyEnglandPHE,
    # tidyEnglandUnitAuth=tidyEnglandUnitAuth,
    # tidyScotlandHealthBoard=tidyScotlandHealthBoard,
    # tidyWalesHealthBoard=tidyWalesHealthBoard,
    # tidyNorthernIrelandLocalGovernmentDistrict=tidyNorthernIreland,
    tidyCombinedUK=tidyCombinedUK,
    tidyCombinedUK_LTLA=tidyCombinedUK_LTLA
  ))
}

#' Cleanse UK outbreak timeseries data
#' 
#' Unofficial UK timeseries data has lots of data quality issues.
#' Various things done to fix:
#' * scales cumulative cases by unknown/total+1 across the board 
#' * calculates incidence and makes sure no negative incidences recorded
#' * updated cumulative_cases to reflect cleaned incidences
#' 
#' @param groupedDf the tidy dataframe grouped by regional geographical areas whatever you have
#' @param dateVar the column containing the date
#' @param cumulativeCasesVar 
#' @param totalVar the total over all the whole geography
#' @param unknownVar 
#' @import dplyr

normaliseAndCleanse = function(groupedDf, dateVar = "date", cumulativeCasesVar = "cumulative_cases", totalExpr = NULL, unknownExpr = NULL, adjustUnknowns=FALSE, smoothWeekly=FALSE, reportDelay=3) {
  grps = groups(groupedDf)
  if (identical(grps,NULL)) warning("the input data is not grouped - this is probably a mistake")
  dateVar = ensym(dateVar)
  cumulativeCasesVar = ensym(cumulativeCasesVar) 
  totalExpr = enexpr(totalExpr)
  if(identical(totalExpr,NULL)) {
    totalExpr = expr(sum(cumulative_cases,na.rm=TRUE))
  }
  unknownExpr = enexpr(unknownExpr)
  if(identical(unknownExpr,NULL)) {
    unknownExpr = expr(0)
  }
  
  tmp = groupedDf %>% select(
    !!!grps,
    date = !!dateVar, 
    src_cumulative_cases= !!cumulativeCasesVar
  ) %>% arrange(date) %>% filter(!is.na(src_cumulative_cases) & (is.na(lead(src_cumulative_cases)) | lead(src_cumulative_cases, default=Inf) > 0))
  
  # find the min / max date ranges for each group.
  # truncate the data set by reportDelay dates for unreliable dates
  tmpDates = tmp %>% group_modify(function(d,f,...) {
    tibble(date = as.Date(min(d$date):(max(d$date)-reportDelay),"1970-01-01"))
  })
  
  # expand the dates to make sure whole range present so each time series
  tmp2 = tmpDates %>% left_join(tmp, by=c(unlist(sapply(grps,as_label)),"date"))

  tmp3 = tmp2 %>% group_by(!!!grps) %>% arrange(date) %>%
    # calculate incidence
    mutate(incidence = lead(src_cumulative_cases)-src_cumulative_cases) %>%
    # mutate(incidence = ifelse(is.na(incidence) & lead(cumulative_cases)==1,1,incidence)) %>%
    # fix elements where incidence < 0 by setting incidence to 0
    mutate(
      cumulative_max = cummax(ifelse(is.na(src_cumulative_cases),-Inf,src_cumulative_cases)),
      cumulative_cases = ifelse(lag(cumulative_max,default = -Inf) > src_cumulative_cases,NA,src_cumulative_cases),
      incidence = ifelse(incidence<0,0,incidence)
    ) 
  
  tmp4 = tmp3 %>%
    # find the smallest value after this one (by ordering descending and finding the smallest value before this one)
    arrange(desc(date)) %>%
    mutate(next_larger = lag(cummin(ifelse(is.na(cumulative_cases),Inf,cumulative_cases)),default = max(cumulative_cases, na.rm = TRUE))) %>%
    # if they are the same then the incidence was zero
    mutate(cumulative_cases = ifelse(cumulative_max==next_larger,cumulative_max,cumulative_cases)) %>%
    arrange(date)
    
  # impute missing incidences by linear interpolation
  tmp4_5 = tmp4 %>% group_by(!!!grps) %>% arrange(date) %>% mutate(
    imputed = is.na(src_cumulative_cases),
    log_cumulative_cases = log(cumulative_cases+1),
    log_cumulative_cases = tryCatch(imputeTS::na_interpolation(log_cumulative_cases), error=function(e) NA)
  ) 
  
  if(smoothWeekly) {
    #tmp4_5 = tmp4_5 %>% mutate(log_cumulative_cases = stats::filter(log_cumulative_cases,filter = rep(1,7)/7))
    tmp4_5 = tmp4_5 %>% mutate(log_cumulative_cases = signal::sgolayfilt(log_cumulative_cases,p=1,n=7))
  }
  
  tmp5 = tmp4_5 %>% mutate(
    cumulative_cases = cummax(exp(log_cumulative_cases)-1)
  ) %>% mutate(
    incidence = lead(cumulative_cases)-cumulative_cases
  ) %>% select(!!!grps,date,src_cumulative_cases,cumulative_cases,incidence,log_cumulative_cases,imputed)
  
  # clear out NA's if there are any
  if(adjustUnknowns) {
    
    tmp6 = groupedDf %>% ungroup() %>% group_by(!!dateVar) %>% summarise(
      total = first(!!totalExpr),
      unknown = first(!!unknownExpr)
    )
    
    tmp5 = tmp5 %>% inner_join(tmp6, by=c("date"))
    
    tmp5 = tmp5 %>% mutate(cumulative_cases = ifelse(unknown>0 & total>0, cumulative_cases*(1+unknown/total), cumulative_cases)) 
    
    tmp5 = tmp5 %>% select(-total,-unknown) 
  } 
  
  # calculate community transmission start date
  tmp9 = tmp5 %>% 
    group_modify(function(d,g,...) {
      if (nrow(d) < 11 | any(is.na(head(d$incidence,-1)))) {
        d = d %>% mutate(
          estimated_exponent = NA,
          community_transmission_date = NA,
          little_r = NA,
        )
      } else {
        #browser()
        d = d %>% mutate(
            #estimated_exponent = signal::sgolayfilt(d %>% mutate(log_cumulative_cases = if_else(log_cumulative_cases < 0, -log(2), log_cumulative_cases)) %>% pull(log_cumulative_cases),p = 1,n = 11,m = 1)
            estimated_exponent = signal::sgolayfilt(d %>% pull(log_cumulative_cases),p = 2,n = 11,m = 1)
          ) %>% mutate(
            #estimated_exponent = if_else(log_cumulative_cases < 0, as.double(NA), estimated_exponent)
          #) %>% mutate(
            little_r = exp(estimated_exponent)-1,
            intercept_date = as.Date(as.numeric(date) - log_cumulative_cases/ifelse(estimated_exponent>0,estimated_exponent,NA),"1970-01-01")
          ) %>% mutate(
            community_transmission_date = suppressWarnings(as.Date(max(intercept_date, na.rm = TRUE),"1970-01-01"))
          ) %>% select(-intercept_date)
        
        #peak_date = (d$date[!is.na(d$incidence) & d$incidence == max(d$incidence, na.rm=TRUE)])[[1]]
        #cases_at_peak = (d$cumulative_cases[!is.na(d$incidence) & d$incidence == max(d$incidence, na.rm=TRUE)])[[1]]
        
        # tmpD = d %>% filter(cumulative_cases > 10 & estimated_exponent_rising) %>% # & cumulative_cases < 0.5*cases_at_peak & date<peak_date) %>% 
        #   top_n(wt = estimated_exponent,n = 5)
        # 
        # tmpD = tmpD %>% mutate(intercept_date = as.Date(as.numeric(date) - log_cumulative_cases/estimated_exponent,"1970-01-01"))
        # intercept_date = median(tmpD$intercept_date)
        # 
        # d$community_transmission_date = rep(intercept_date,nrow(d))
        #d = d %>% select(-estimated_exponent_delta)
      }
      # tmpD = d %>% filter(cumulative_cases > 0.2*cases_at_peak & cumulative_cases < 0.5*cases_at_peak & date<peak_date)
      # browser()
      # if(nrow(tmpD %>% filter(!is.na(log_cumulative_cases))) == 0) {
      #   d$community_transmission_date = rep(NA,nrow(d))
      #   #d$initial_exponent = rep(NA,nrow(d))
      # } else if(nrow(tmpD) < 7) {
      #   tmpD = d %>% filter(log_cumulative_cases > 0.25*max(d$log_cumulative_cases) & log_cumulative_cases < 0.5*max(d$log_cumulative_cases))
      #   model = lm(date ~ log_cumulative_cases, data=tmpD)
      #   intercept_date = as.Date((model$coefficients)[[1]],"1970-01-01")
      #   slope = (model$coefficients)[[2]]
      #   d$community_transmission_date = rep(intercept_date,nrow(d))
      #   #d$initial_exponent = rep(slope,nrow(d))
      # } else {
      #   tmpD = tmpD %>% mutate(slope = signal::sgolayfilt(tmpD$log_cumulative_cases,3,7,1))
      #   tmpD = tmpD %>% mutate(intercept_date = as.numeric(date) - log_cumulative_cases/slope)
      #   intercept_date = as.Date(median(tmpD$intercept_date),"1970-01-01")
      #   d$community_transmission_date = rep(intercept_date,nrow(d))
      #   #d$initial_exponent = rep(mean(tmpD$slope),nrow(d))
      # }
      # browser()
      return(d)
    })
  
  
  
  return(tmp9)
}

#' Calculate an estimate of rate of change of Rt
#' 
#' @param R0timeseries a grouped df contianing R0 timeseries including a date and a `Median(R)` column from EpiEstim
#' @import dplyr

deltaR0timeseries = function(R0timeseries, dateVar = "date") {
  dateVar = ensym(dateVar)
  if (!(as_label(dateVar) %in% colnames(R0timeseries))) stop("no dateVar column in input")  
  tmp = R0timeseries %>% rename(date = !!dateVar) %>% group_modify(function(d,g,...) {
    if ((min(d$date)+10)>max(d$date)) return(tibble(date=as.Date(NA),slope=as.double(NA),slopeLowerCi=as.double(NA),slopeUpperCi=as.double(NA),r_squared=as.double(NA)))
    endDate = seq((min(d$date)+10),max(d$date),1)
    r0s = sapply(endDate, function(x) d$`Median(R)`[d$date > x-10 & d$date <=x]) # hopefully a vector of vectors
    dates = sapply(endDate, function(x) d$date[d$date > x-10 & d$date <=x])
    out = NULL
    
    for (i in 1:ncol(r0s)) {
      # cant be arsed trying to vectorise this.
      date=as.Date(dates[,i],origin=as.Date("1970-01-01"))
      r=r0s[,i]
      suppressWarnings({
        lmResult = lm(r~date,data=tibble(r=r,date=date))
        out = out %>% bind_rows(tibble(
          date = max(date),
          slope = summary(lmResult)$coefficients[[2]],
          slopeLowerCi = as.double(confint(lmResult, "date", level=0.95)[[1]]),
          slopeUpperCi = as.double(confint(lmResult, "date", level=0.95)[[2]]),
          r_squared = summary(lmResult)$r.squared
        ))
      })
    }
    return(d %>% left_join(out,by="date"))
  })
  return(tmp %>% rename(!!dateVar := date))
}

#' Plot the EpiEstim output in a standard way
#' 
#' @param df a df containing an Rt timeseries, including a date and a `Median(R)` column from EpiEstim
#' @param group - the colour aesthetic
#' @param dateVar - the name of the date column
#' @param facetVars - the facetting variables
#' @param features - 
#' @param rtlim - the max and min or Rt to display
#' @param dates - the min (and optionally max) dates to display as a YYYY-MM-DD character (or anything that can be coerced to a Date)
#' @import dplyr

plotRt = function(df, group=NULL, dateVar = "date", facetVars = NULL, features=c("lockdown","easter"), rtlim=c(0.5,2.5), dates="2020-03-09") {
  group = tryCatch(ensym(group),error = function(e) NULL)
  dateVar = ensym(dateVar)
  dates = as.Date(dates)
  if (length(dates) == 1) dates = c(dates,Sys.Date())
  
  p2 = ggplot(df,aes(x=!!dateVar, y=`Median(R)`, ymin=`Quantile.0.025(R)`, ymax=`Quantile.0.975(R)`))
  
  if("easter" %in% features) p2 = p2 + geom_rect(xmin=as.Date("2020-04-10"),xmax=as.Date("2020-04-14"),ymin=-Inf,ymax=Inf,fill="grey90",colour="grey90")
  if("lockdown" %in% features) p2 = p2 + geom_vline(xintercept = as.Date("2020-03-23"),colour="black",linetype="dashed")
  
  if(identical(group,NULL)) {
    p2 = p2 + geom_line()+
      geom_ribbon(alpha=0.2,show.legend = FALSE)
  } else {
    p2 = p2 +geom_line(aes(colour=!!group))+
      geom_ribbon(aes(fill=!!group),alpha=0.2,show.legend = FALSE)
  }
  p2 = p2 + geom_hline(yintercept = 1,colour="grey50")+
    scale_x_date(date_breaks = "2 week", date_labels = "%d-%m")+
    coord_cartesian(ylim=rtlim,xlim=dates)+standardPrintOutput::narrower()
  if(!identical(facetVars,NULL)) {
    p2 = p2 + facet_wrap(facetVars)
  }
  return(p2)
}

# getDemographics = function() {
#   library(readxl)
#   url <- "https://www.ons.gov.uk/file?uri=%2fpeoplepopulationandcommunity%2fpopulationandmigration%2fpopulationestimates%2fdatasets%2fpopulationestimatesforukenglandandwalesscotlandandnorthernireland%2fmid20182019laboundaries/ukmidyearestimates20182019ladcodes.xls"
#   destfile <- "ukmidyearestimates20182019ladcodes.xls"
#   curl::curl_download(url, destfile)
#   ukmidyearestimates20182019ladcodes <- read_excel(destfile)
#   View(ukmidyearestimates20182019ladcodes)
# }