% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UKDemographicsProvider.R
\name{UKDemographicsProvider}
\alias{UKDemographicsProvider}
\title{UK ONS demographics}
\description{
UK ONS demographics

UK ONS demographics
}
\section{Super class}{
\code{\link[ukcovidtools:PassthroughFilesystemCache]{ukcovidtools::PassthroughFilesystemCache}} -> \code{UKDemographicsProvider}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-getDetailedDemographics}{\code{UKDemographicsProvider$getDetailedDemographics()}}
\item \href{#method-getDemographicsMap}{\code{UKDemographicsProvider$getDemographicsMap()}}
\item \href{#method-getDemographicsForShape}{\code{UKDemographicsProvider$getDemographicsForShape()}}
\item \href{#method-getDemographicsForCodeTypes}{\code{UKDemographicsProvider$getDemographicsForCodeTypes()}}
\item \href{#method-getDemographicsFromWeightedMapping}{\code{UKDemographicsProvider$getDemographicsFromWeightedMapping()}}
\item \href{#method-getSingleDigitDemographics}{\code{UKDemographicsProvider$getSingleDigitDemographics()}}
\item \href{#method-transitiveClosureWeightedMap}{\code{UKDemographicsProvider$transitiveClosureWeightedMap()}}
\item \href{#method-findDemographics}{\code{UKDemographicsProvider$findDemographics()}}
\item \href{#method-clone}{\code{UKDemographicsProvider$clone()}}
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
\if{html}{\out{<a id="method-getDetailedDemographics"></a>}}
\subsection{Method \code{getDetailedDemographics()}}{
get the full range of demographics data at most detailed resolution
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$getDetailedDemographics(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getDemographicsMap"></a>}}
\subsection{Method \code{getDemographicsMap()}}{
LSOA & Scottish Data Zones
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$getDemographicsMap(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getDemographicsForShape"></a>}}
\subsection{Method \code{getDemographicsForShape()}}{
get demographics interpolated to a specific shape file and aggregated to a given set of age bands, with optionally combining genders
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$getDemographicsForShape(
  mapId,
  outputShape = self$geog$getMap(mapId),
  outputVars = vars(code, name),
  ageBreaks = seq(5, 90, 5),
  combineGenders = FALSE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{mapId}}{= the mapId}

\item{\code{outputShape}}{= the sf object containing the shapefile of the desired output which may be grouped by desired output}

\item{\code{outputVars}}{= the desired output columns from the output shapefile enclosed by vars(...) (defaults to code and name)}

\item{\code{ageBreaks}}{= where to cut age groups? e.g. c(15,65,80) (max 90)}

\item{\code{combineGenders}}{= merge the genders}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getDemographicsForCodeTypes"></a>}}
\subsection{Method \code{getDemographicsForCodeTypes()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$getDemographicsForCodeTypes(
  codeTypes,
  ageBreaks = seq(5, 90, 5),
  combineGenders = FALSE
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getDemographicsFromWeightedMapping"></a>}}
\subsection{Method \code{getDemographicsFromWeightedMapping()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$getDemographicsFromWeightedMapping(
  mappingDf,
  fromCodeVar = "fromCode",
  toCodeVar = "toCode",
  outputCodeVar = "code",
  weightExpr = 1,
  ageBreaks = seq(5, 90, 5),
  combineGenders = FALSE
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getSingleDigitDemographics"></a>}}
\subsection{Method \code{getSingleDigitDemographics()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$getSingleDigitDemographics(
  mappingDf,
  fromCodeVar = "fromCode",
  toCodeVar = "toCode",
  outputCodeVar = "code",
  weightExpr = 1,
  combineGenders = FALSE
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-transitiveClosureWeightedMap"></a>}}
\subsection{Method \code{transitiveClosureWeightedMap()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$transitiveClosureWeightedMap(
  df,
  codeVar = "code",
  codeTypeVar = "codeType",
  ...
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-findDemographics"></a>}}
\subsection{Method \code{findDemographics()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$findDemographics(
  df,
  codeVar = "code",
  codeTypeVar = "codeType",
  ageCatVar = "ageCat",
  genderVar = "gender",
  ...
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKDemographicsProvider$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
