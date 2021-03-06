% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/UKGeographyProvider.R
\name{UKGeographyProvider}
\alias{UKGeographyProvider}
\title{UK Geography}
\description{
UK Geography

UK Geography
}
\section{Super class}{
\code{\link[ukcovidtools:PassthroughFilesystemCache]{ukcovidtools::PassthroughFilesystemCache}} -> \code{UKGeographyProvider}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-getMap}{\code{UKGeographyProvider$getMap()}}
\item \href{#method-getPHEDashboardMap}{\code{UKGeographyProvider$getPHEDashboardMap()}}
\item \href{#method-getIntersection}{\code{UKGeographyProvider$getIntersection()}}
\item \href{#method-getContainedIn}{\code{UKGeographyProvider$getContainedIn()}}
\item \href{#method-interpolateByArea}{\code{UKGeographyProvider$interpolateByArea()}}
\item \href{#method-createNeighbourNetwork}{\code{UKGeographyProvider$createNeighbourNetwork()}}
\item \href{#method-standardiseMap}{\code{UKGeographyProvider$standardiseMap()}}
\item \href{#method-saveShapefile}{\code{UKGeographyProvider$saveShapefile()}}
\item \href{#method-loadAllMaps}{\code{UKGeographyProvider$loadAllMaps()}}
\item \href{#method-createCatchment}{\code{UKGeographyProvider$createCatchment()}}
\item \href{#method-preview}{\code{UKGeographyProvider$preview()}}
\item \href{#method-plot}{\code{UKGeographyProvider$plot()}}
\item \href{#method-clone}{\code{UKGeographyProvider$clone()}}
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
\if{html}{\out{<a id="method-getMap"></a>}}
\subsection{Method \code{getMap()}}{
get a map as an sf object
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$getMap(mapId, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{codeType}}{the map you want}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getPHEDashboardMap"></a>}}
\subsection{Method \code{getPHEDashboardMap()}}{
England LADs, Scotland Health Board, Wales Health Board
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$getPHEDashboardMap(...)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getIntersection"></a>}}
\subsection{Method \code{getIntersection()}}{
get the intersection between to maps with ids. Caches the result in the working directory.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$getIntersection(
  inputMapId,
  inputShape = self$getMap(inputMapId),
  outputMapId,
  outputShape = self$getMap(outputMapId),
  ...
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-getContainedIn"></a>}}
\subsection{Method \code{getContainedIn()}}{

\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$getContainedIn(
  inputSf,
  outputShape = self$getMap(outputMapId),
  outputMapId = NA,
  inputIdVar = "code",
  outputIdVar = "code"
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-interpolateByArea"></a>}}
\subsection{Method \code{interpolateByArea()}}{
interpolate a variable from one set of shapes to another
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$interpolateByArea(
  inputDf,
  inputMapId,
  inputShape = self$getMap(inputMapId),
  inputIdVar = "code",
  interpolateVar,
  outputMapId,
  outputShape = self$getMap(outputMapId) \%>\% dplyr::group_by(codeType, code, name),
  outputVars = outputShape \%>\% dplyr::groups(),
  aggregateFn = sum
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{inputDf}}{- a grouped dataframe containing the statistic to be interpolated}

\item{\code{inputShape}}{- an input map,}

\item{\code{inputIdVar}}{- an id shared between the grouped data fram and the input map,}

\item{\code{interpolateVar}}{- the statistic,}

\item{\code{outputShape}}{- an output map which must be grouped by the desired output,}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
a dataframe containing the grouping columns, the outputIdVar and the interpolated value of interpolateVar
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-createNeighbourNetwork"></a>}}
\subsection{Method \code{createNeighbourNetwork()}}{
create a neighbourhood network from a shapefile
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$createNeighbourNetwork(
  mapId,
  shape = self$getMap(mapId) \%>\% dplyr::group_by(code, name),
  idVar = "code",
  ...
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{mapId}}{- a the ID of the map}

\item{\code{shape}}{- a sf object, if not present will be loaded from cache}

\item{\code{idVar}}{- the varable containing the coded identifier of the map}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
an edge list of ids with from and to columns
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-standardiseMap"></a>}}
\subsection{Method \code{standardiseMap()}}{
standardise all maps to a minimal set of attributes with consistent naming
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$standardiseMap(sf, codeCol, nameCol, altCodeCol, codeType)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-saveShapefile"></a>}}
\subsection{Method \code{saveShapefile()}}{
save a shapefile to disk in the current working directory
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$saveShapefile(
  mapId,
  shape = self$getMap(mapId),
  overwrite = FALSE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{mapId}}{- a mapId - will become the zip filename}

\item{\code{-}}{a zip directory}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
a dataframe containing the grouping columns, the outputIdVar and the interpolated value of interpolateVar
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-loadAllMaps"></a>}}
\subsection{Method \code{loadAllMaps()}}{
warm up caches
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$loadAllMaps()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-createCatchment"></a>}}
\subsection{Method \code{createCatchment()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$createCatchment(
  supplyShape,
  supplyIdVar = "code",
  supplyVar,
  supplyOutputVars = supplyShape \%>\% dplyr::groups(),
  demandId,
  demandShape,
  demandIdVar = "code",
  demandVar,
  growthRates = function(capacityPerDemand, multiplier = 1.1) {    
    return(rank(capacityPerDemand)/length(capacityPerDemand) * multiplier) },
  distanceModifier = function(distanceToSupply) {     return(2/(1 +
    distanceToSupply/min(0.1, mean(distanceToSupply)))) },
  tweakNetwork = self$sources$tweak$DEMOG,
  outputMap = TRUE
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-preview"></a>}}
\subsection{Method \code{preview()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$preview(
  shape = self$getMap(mapId),
  mapId = NA,
  nameVar = "name",
  codeVar = "code",
  poi = NULL,
  poiNameVar = "name",
  poiCodeVar = "code"
)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-plot"></a>}}
\subsection{Method \code{plot()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$plot(shape = self$getMap(mapId), mapId = NA)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{UKGeographyProvider$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
