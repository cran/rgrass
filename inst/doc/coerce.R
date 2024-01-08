## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, paged.print=FALSE)

## ----out.width=500, echo=FALSE------------------------------------------------
knitr::include_graphics("fig1.png")

## ----out.width=500, echo=FALSE------------------------------------------------
knitr::include_graphics("fig2_p7_RRASTER_GRASS.png")

## ----include=FALSE, message=FALSE---------------------------------------------
terra_available <- requireNamespace("terra", quietly=TRUE)
sf_available <- requireNamespace("sf", quietly=TRUE)
sp_available <- requireNamespace("sp", quietly=TRUE)
stars_available <- requireNamespace("stars", quietly=TRUE) && packageVersion("stars") > "0.5.4"
raster_available <- requireNamespace("raster", quietly=TRUE)

## ----eval=terra_available-----------------------------------------------------
library("terra")

## ----eval=sf_available--------------------------------------------------------
library("sf")

## ----eval=sp_available--------------------------------------------------------
library("sp")

## ----eval=stars_available-----------------------------------------------------
library("stars")

## ----eval=raster_available----------------------------------------------------
library("raster")

## ----eval=terra_available-----------------------------------------------------
gdal(lib="all")

## ----eval=terra_available-----------------------------------------------------
fv <- system.file("ex/lux.shp", package="terra")
(v <- vect(fv))

## ----, eval=terra_available---------------------------------------------------
try(inMemory(v))

## ----, eval=terra_available---------------------------------------------------
cat(crs(v), "\n")

## ----eval=(terra_available && sf_available)-----------------------------------
v_sf <- st_as_sf(v)
v_sf

## ----eval=(terra_available && sf_available)-----------------------------------
v_sf_rt <- vect(v_sf)
v_sf_rt

## ----eval=(terra_available && sf_available)-----------------------------------
all.equal(v_sf_rt, v, check.attributes=FALSE)

## ----eval=(terra_available && raster_available && sp_available)---------------
v_sp <- as(v, "Spatial")
print(summary(v_sp))

## ----eval=(terra_available && sf_available && sp_available)-------------------
v_sp_rt <- vect(st_as_sf(v_sp))
all.equal(v_sp_rt, v, check.attributes=FALSE)

## ----eval=terra_available-----------------------------------------------------
fr <- system.file("ex/elev.tif", package="terra")
(r <- rast(fr))

## ----eval=terra_available-----------------------------------------------------
try(inMemory(r))

## ----eval=(terra_available && stars_available)--------------------------------
r_stars <- st_as_stars(r)
print(r_stars)

## ----eval=(terra_available && stars_available)--------------------------------
(r_stars_rt <- rast(r_stars))

## ----eval=(terra_available && stars_available)--------------------------------
(r_stars_p <- st_as_stars(r, proxy=TRUE))

## ----eval=(terra_available && stars_available)--------------------------------
(r_stars_p_rt <- rast(r_stars_p))

## ----eval=(terra_available && raster_available)-------------------------------
(r_RL <- raster(r))

## ----eval=(terra_available && raster_available)-------------------------------
inMemory(r_RL)

## ----eval=(terra_available && raster_available)-------------------------------
cat(wkt(r_RL), "\n")

## ----eval=(terra_available && raster_available)-------------------------------
(r_RL_rt <- rast(r_RL))

## ----eval=(terra_available && raster_available && sp_available)---------------
r_sp_RL <- as(r_RL, "SpatialGridDataFrame")
summary(r_sp_RL)

## ----eval=(terra_available && raster_available && sp_available)---------------
cat(wkt(r_sp_RL), "\n")

## ----eval=(terra_available && raster_available && sp_available)---------------
(r_sp_RL_rt <- raster(r_sp_RL))
cat(wkt(r_sp_RL_rt), "\n")

## ----eval=(terra_available && raster_available && sp_available)---------------
(r_sp_rt <- rast(r_sp_RL_rt))

## ----eval=(terra_available && raster_available && sp_available)---------------
crs(r_sp_RL_rt)

## ----eval=(terra_available && stars_available && sp_available)----------------
r_sp_stars <- as(r_stars, "Spatial")
summary(r_sp_stars)

## ----eval=(terra_available && stars_available && sp_available)----------------
cat(wkt(r_sp_stars), "\n")

## ----eval=(terra_available && stars_available && sp_available)----------------
(r_sp_stars_rt <- rast(st_as_stars(r_sp_stars)))

## ----eval=(terra_available && stars_available && sp_available)----------------
cat(crs(r_sp_rt), "\n")

