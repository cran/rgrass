## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, paged.print=FALSE)

## ---- out.width=500, echo=FALSE-----------------------------------------------
knitr::include_graphics("fig1.png")

## ---- out.width=500, echo=FALSE-----------------------------------------------
knitr::include_graphics("fig2_p7_RRASTER_GRASS.png")

## -----------------------------------------------------------------------------
run <- require("terra", quietly=TRUE)

## ---- eval=run----------------------------------------------------------------
gdal(lib="all")

## -----------------------------------------------------------------------------
fv <- system.file("ex/lux.shp", package="terra")
(v <- vect(fv))

## ---- eval=run----------------------------------------------------------------
try(inMemory(v))

## ---- eval=run----------------------------------------------------------------
cat(crs(v), "\n")

## ---- eval=run----------------------------------------------------------------
no_sf <- inherits(try(require("sf")), "try-error")

## ---- eval=(run && !no_sf)----------------------------------------------------
v_sf <- st_as_sf(v)
v_sf

## ---- eval=(run && !no_sf)----------------------------------------------------
v_sf_rt <- vect(v_sf)
v_sf_rt

## ---- eval=(run && !no_sf)----------------------------------------------------
all.equal(v_sf_rt, v, check.attributes=FALSE)

## ---- eval=(run && !no_sf)----------------------------------------------------
Sys.setenv("_SP_EVOLUTION_STATUS_"="2")
no_sp <- inherits(try(require("sp", quietly=TRUE)), "try-error")

## ---- eval=(run && !no_sf && !no_sp)------------------------------------------
v_sp <- as(v_sf, "Spatial")
print(summary(v_sp))

## ---- eval=(run && !no_sf && !no_sp)------------------------------------------
v_sp_rt <- vect(st_as_sf(v_sp))
all.equal(v_sp_rt, v, check.attributes=FALSE)

## ---- eval=run----------------------------------------------------------------
fr <- system.file("ex/elev.tif", package="terra")
(r <- rast(fr))

## ---- eval=run----------------------------------------------------------------
try(inMemory(r))

## ---- eval=run----------------------------------------------------------------
no_stars <- inherits(try(require("stars", quietly=TRUE)), "try-error")

## ---- eval=(run && !no_stars)-------------------------------------------------
r_stars <- st_as_stars(r)
print(r_stars)

## ---- eval=(run && !no_stars)-------------------------------------------------
(r_stars_rt <- rast(r_stars))

## ---- eval=(run && !no_stars)-------------------------------------------------
(r_stars_p <- st_as_stars(r, proxy=TRUE))

## ---- eval=(run && !no_stars)-------------------------------------------------
(r_stars_p_rt <- rast(r_stars_p))

## ---- eval=(run && !no_sp && !no_stars)---------------------------------------
r_sp <- as(r_stars, "Spatial")
summary(r_sp)

## ---- eval=(run && !no_sp && !no_stars)---------------------------------------
(r_sp_rt <- rast(st_as_stars(r_sp)))

## ---- eval=run----------------------------------------------------------------
tf <- tempfile(fileext=".grd")
terra::writeRaster(r, filename=tf, filetype="RRASTER")

## ---- eval=run----------------------------------------------------------------
no_raster <- inherits(try(require("raster", quietly=TRUE)), "try-error")

## ---- eval=(run && !no_raster)------------------------------------------------
(r_RL <- raster(tf))

## ---- eval=(run && !no_raster)------------------------------------------------
(r_RL_rt <- rast(r_RL))

