## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, paged.print=FALSE)

## ---- out.width=500, echo=FALSE-----------------------------------------------
knitr::include_graphics("fig1.png")

## ---- out.width=500, echo=FALSE-----------------------------------------------
knitr::include_graphics("fig2_p7_RRASTER_GRASS.png")

## -----------------------------------------------------------------------------
terra_available <- require("terra", quietly=TRUE)
sf_available <- require("sf", quietly=TRUE)
Sys.setenv("_SP_EVOLUTION_STATUS_"="2")
sp_available <- require("sp", quietly=TRUE)
stars_available <- require("stars", quietly=TRUE) && packageVersion("stars") > "0.5.4"
raster_available <- require("raster", quietly=TRUE)

## ---- eval=terra_available----------------------------------------------------
gdal(lib="all")

## ---- eval=terra_available----------------------------------------------------
fv <- system.file("ex/lux.shp", package="terra")
(v <- vect(fv))

## ---- , eval=terra_available--------------------------------------------------
try(inMemory(v))

## ---- , eval=terra_available--------------------------------------------------
cat(crs(v), "\n")

## ---- eval=(terra_available && sf_available)----------------------------------
v_sf <- st_as_sf(v)
v_sf

## ---- eval=(terra_available && sf_available)----------------------------------
v_sf_rt <- vect(v_sf)
v_sf_rt

## ---- eval=(terra_available && sf_available)----------------------------------
all.equal(v_sf_rt, v, check.attributes=FALSE)

## ---- eval=(terra_available && sf_available && sp_available)------------------
v_sp <- as(v_sf, "Spatial")
print(summary(v_sp))

## ---- eval=(terra_available && sf_available && sp_available)------------------
v_sp_rt <- vect(st_as_sf(v_sp))
all.equal(v_sp_rt, v, check.attributes=FALSE)

## ---- eval=terra_available----------------------------------------------------
fr <- system.file("ex/elev.tif", package="terra")
(r <- rast(fr))

## ---- eval=terra_available----------------------------------------------------
try(inMemory(r))

## ---- eval=(terra_available && stars_available)-------------------------------
r_stars <- st_as_stars(r)
print(r_stars)

## ---- eval=(terra_available && stars_available)-------------------------------
(r_stars_rt <- rast(r_stars))

## ---- eval=(terra_available && stars_available)-------------------------------
(r_stars_p <- st_as_stars(r, proxy=TRUE))

## ---- eval=(terra_available && stars_available)-------------------------------
(r_stars_p_rt <- rast(r_stars_p))

## ---- eval=(terra_available && stars_available && sp_available)---------------
r_sp <- as(r_stars, "Spatial")
summary(r_sp)

## ---- eval=(terra_available && stars_available && sp_available)---------------
(r_sp_rt <- rast(st_as_stars(r_sp)))

## ---- eval=(terra_available && raster_available)------------------------------
(r_RL <- raster(r))

## ---- eval=(terra_available && raster_available)------------------------------
inMemory(r_RL)

## ---- eval=(terra_available && raster_available)------------------------------
(r_RL_rt <- rast(r_RL))

