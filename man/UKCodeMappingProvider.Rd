% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UKCodeMappingProvider.R
\name{UKCodeMappingProvider}
\alias{UKCodeMappingProvider}
\title{Process UK ONS code maps}
\description{
Process UK ONS code maps

Process UK ONS code maps
}
\section{Super class}{
\code{\link[ukcovidtools:PassthroughFilesystemCache]{ukcovidtools::PassthroughFilesystemCache}} -> \code{UKCodeMappingProvider}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-getONSMappings}{\code{UKCodeMappingProvider$getONSMappings()}}
\item \href{#method-getONSRegister}{\code{UKCodeMappingProvider$getONSRegister()}}
\item \href{#method-getManualMappings}{\code{UKCodeMappingProvider$getManualMappings()}}
\item \href{#method-getODSMappings}{\code{UKCodeMappingProvider$getODSMappings()}}
\item \href{#method-getODSCodes}{\code{UKCodeMappingProvider$getODSCodes()}}
\item \href{#method-getManualCodes}{\code{UKCodeMappingProvider$getManualCodes()}}
\item \href{#method-getMappings}{\code{UKCodeMappingProvider$getMappings()}}
\item \href{#method-getTransitiveClosure}{\code{UKCodeMappingProvider$getTransitiveClosure()}}
\item \href{#method-getCodes}{\code{UKCodeMappingProvider$getCodes()}}
\item \href{#method-getDescriptions}{\code{UKCodeMappingProvider$getDescriptions()}}
\item \href{#method-findCodesByName}{\code{UKCodeMappingProvider$findCodesByName()}}
\item \href{#method-findNamesByCode}{\code{UKCodeMappingProvider$findNamesByCode()}}
\item \href{#method-clone}{\code{UKCodeMappingProvider$clone()}}
}
}
\if{html}{
\out{<details ><summary>Inherited methods</summary>}
\itemize{
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="ageCatToFactor">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-ageCatToFactor}{\code{ukcovidtools::PassthroughFilesystemCache$ageCatToFactor()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="ageToAgeCat">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-ageToAgeCat}{\code{ukcovidtools::PassthroughFilesystemCache$ageToAgeCat()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="breakFromCats">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-breakFromCats}{\code{ukcovidtools::PassthroughFilesystemCache$breakFromCats()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="cutByAge">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-cutByAge}{\code{ukcovidtools::PassthroughFilesystemCache$cutByAge()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="download">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-download}{\code{ukcovidtools::PassthroughFilesystemCache$download()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="downloadAndUnzip">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-downloadAndUnzip}{\code{ukcovidtools::PassthroughFilesystemCache$downloadAndUnzip()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="downloadDaily">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-downloadDaily}{\code{ukcovidtools::PassthroughFilesystemCache$downloadDaily()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="getDaily">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-getDaily}{\code{ukcovidtools::PassthroughFilesystemCache$getDaily()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="getHashCached">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-getHashCached}{\code{ukcovidtools::PassthroughFilesystemCache$getHashCached()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="getSaved">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-getSaved}{\code{ukcovidtools::PassthroughFilesystemCache$getSaved()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="importTimeseries">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-importTimeseries}{\code{ukcovidtools::PassthroughFilesystemCache$importTimeseries()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="initialize">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-initialize}{\code{ukcovidtools::PassthroughFilesystemCache$initialize()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="ukcovidtools" data-topic="PassthroughFilesystemCache" data-id="normaliseGender">}\href{../../ukcovidtools/html/PassthroughFilesystemCache.html#method-normaliseGender}{\code{ukcovidtools::PassthroughFilesystemCache$normaliseGender()}}\out{</span>}
}
\out{</details>}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getONSMappings"></a>}}
\subsection{Method \code{getONSMappings()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getONSMappings(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getONSRegister"></a>}}
\subsection{Method \code{getONSRegister()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getONSRegister(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getManualMappings"></a>}}
\subsection{Method \code{getManualMappings()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getManualMappings(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getODSMappings"></a>}}
\subsection{Method \code{getODSMappings()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getODSMappings(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getODSCodes"></a>}}
\subsection{Method \code{getODSCodes()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getODSCodes(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getManualCodes"></a>}}
\subsection{Method \code{getManualCodes()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getManualCodes(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getMappings"></a>}}
\subsection{Method \code{getMappings()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getMappings(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getTransitiveClosure"></a>}}
\subsection{Method \code{getTransitiveClosure()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getTransitiveClosure(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getCodes"></a>}}
\subsection{Method \code{getCodes()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getCodes(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getDescriptions"></a>}}
\subsection{Method \code{getDescriptions()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$getDescriptions(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-findCodesByName"></a>}}
\subsection{Method \code{findCodesByName()}}{
Get codes from name
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$findCodesByName(
  df,
  nameVar = "name",
  outputCodeVar = "code",
  outputCodeTypeVar = "codeType",
  codeTypes = c("LSOA", "CCG", "HB", "LHB", "NHSER", "PHEC", "LAD", "UA", "NHS site",
    "NHS trust", "CTRY", "UK")
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{df}}{a dataframe containing at least a nameVar column}

\item{\code{nameVar}}{the column name of the name to lookup (default "name")}

\item{\code{outputCodeVar}}{the column name of the code to return (default "code")}

\item{\code{outputCodeTypeVar}}{the column name of the codeType to return (default "codeType") or NULL for no codeType column}

\item{\code{codeTypes}}{- a list of codeTypes to constrain the search (or NULL for no restriction)}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
a dataframe containing nameVar, outputCodeVar, outputCodeTypeVar
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-findNamesByCode"></a>}}
\subsection{Method \code{findNamesByCode()}}{
Get canonical names from code
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$findNamesByCode(
  df,
  codeVar = "code",
  outputNameVar = "name",
  outputCodeTypeVar = "codeType",
  codeTypes = NULL
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{df}}{a dataframe containing at least a nameVar column}

\item{\code{codeVar}}{the column name of the code to lookup (default "code")}

\item{\code{outputNameVar}}{the column name of the code to return (default "name")}

\item{\code{outputCodeTypeVar}}{the column name of the name to lookup (default "codeType") or NULL for no codeType column}

\item{\code{codeTypes}}{- a list of codeTypes to constrain the search (or NULL for no restriction)}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
a dataframe containing nameVar, outputCodeVar, outputCodeTypeVar
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKCodeMappingProvider$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
