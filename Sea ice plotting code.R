rm(list = ls())
library(ncdf4) # package for netcdf manipulation
library(raster) # package for raster manipulation
library(rgdal) # package for geospatial analysis
library(ggplot2) # package for plotting
library(tidync)
library(tidyr)
library(easyNCDF)
library(maps)
library(maptools)
library(rasterVis)
library(sp)
library(lattice)
library(RColorBrewer)
library(geosphere)
library(dplyr)
library(ncdf4)
library(raster)
library(rasterVis)
library(RColorBrewer)
library(ggplot2)
library(ggthemes)
library(zoo)
library(sf)

#set up time slices
ncpath <- "~/Documents/GitHub/Llangorse-sea-ice-code/Data files/"
ncname17 <- "17kamean" 
ncin17aut <- "17kaAutumn"
ncin17sum <- '17kaSummer'
ncin17spr <- '17kaSpring'
ncin17win <- '17kaWinter'
ncname16 <- "16kamean" 
ncin16aut <- "16kaAutumn"
ncin16sum <- '16kaSummer'
ncin16spr <- '16kaSpring'
ncin16win <- '16kaWinter'
ncname15.5 <- "15.5kamean" 
ncin15.5aut <- "15.5kaAutumn"
ncin15.5sum <- '15.5kaSummer'
ncin15.5spr <- '15.5kaSpring'
ncin15.5win <- '15.5kaWinter'
ncname15 <- "15kamean"  
ncin15aut <- "15kaAutumn"
ncin15sum <- '15kaSummer'
ncin15spr <- '15kaSpring'
ncin15win <- '15kaWinter'
ncname14.5 <- "14.5kamean"  
ncin14.5aut <- "14.5kaAutumn"
ncin14.5sum <- '14.5kaSummer'
ncin14.5spr <- '14.5kaSpring'
ncin14.5win <- '14.5kaWinter'


ncfname17ka <- paste(ncpath, ncname17, ".nc", sep="")
ncfname17kaWinter <- paste(ncpath, ncin17win, ".nc", sep="")
ncfname17kaSpring <- paste(ncpath, ncin17spr, ".nc", sep="")
ncfname17kaSummer <- paste(ncpath, ncin17sum, ".nc", sep="")
ncfname17kaAutumn <- paste(ncpath, ncin17aut, ".nc", sep="")


ncfname16ka <- paste(ncpath, ncname16, ".nc", sep="")
ncfname16kaWinter <- paste(ncpath, ncin16win, ".nc", sep="")
ncfname16kaSpring <- paste(ncpath, ncin16spr, ".nc", sep="")
ncfname16kaSummer <- paste(ncpath, ncin16sum, ".nc", sep="")
ncfname16kaAutumn <- paste(ncpath, ncin16aut, ".nc", sep="")

ncfname15.5ka <- paste(ncpath, ncname15.5, ".nc", sep="")
ncfname15.5kaWinter <- paste(ncpath, ncin15.5win, ".nc", sep="")
ncfname15.5kaSpring <- paste(ncpath, ncin15.5spr, ".nc", sep="")
ncfname15.5kaSummer <- paste(ncpath, ncin15.5sum, ".nc", sep="")
ncfname15.5kaAutumn <- paste(ncpath, ncin15.5aut, ".nc", sep="")

ncfname15ka <- paste(ncpath, ncname15, ".nc", sep="")
ncfname15kaWinter <- paste(ncpath, ncin15win, ".nc", sep="")
ncfname15kaSpring <- paste(ncpath, ncin15spr, ".nc", sep="")
ncfname15kaSummer <- paste(ncpath, ncin15sum, ".nc", sep="")
ncfname15kaAutumn <- paste(ncpath, ncin15aut, ".nc", sep="")

ncfname14.5ka <- paste(ncpath, ncname14.5, ".nc", sep="")
ncfname14.5kaWinter <- paste(ncpath, ncin14.5win, ".nc", sep="")
ncfname14.5kaSpring <- paste(ncpath, ncin14.5spr, ".nc", sep="")
ncfname14.5kaSummer <- paste(ncpath, ncin14.5sum, ".nc", sep="")
ncfname14.5kaAutumn <- paste(ncpath, ncin14.5aut, ".nc", sep="")

dname <- "ICEFRAC"  # note: tmp means temperature (not temporary)

# get lat lon variables
ncin17 <- nc_open(ncfname17ka)
print(ncin17)
lon <- ncvar_get(ncin17,"lon")
nlon <- dim(lon)
head(lon)
lat <- ncvar_get(ncin17,"lat")
nlat <- dim(lat)
head(lat)

print(c(nlon,nlat))
time <- ncvar_get(ncin17,"time")

#issue with the lon after cdo  mean calculation. This is used to correct this issue 
lona <-lon[1:48]
lonb <-lon[49:96] -360
lonc<- c(lona, lonb)
print(lonc)

# Open calculated mean .nc files for each time slice
ncin17 <- nc_open(ncfname17ka)
ncin17aut <- nc_open(ncfname17kaAutumn)
ncin17spr <- nc_open(ncfname17kaSpring)
ncin17win <- nc_open(ncfname17kaWinter)
ncin17sum <- nc_open(ncfname17kaSummer)

ncin16 <- nc_open(ncfname16ka)
ncin16aut <- nc_open(ncfname16kaAutumn)
ncin16spr <- nc_open(ncfname16kaSpring)
ncin16win <- nc_open(ncfname16kaWinter)
ncin16sum <- nc_open(ncfname16kaSummer)

ncin15.5 <- nc_open(ncfname15.5ka)
ncin15.5aut <- nc_open(ncfname15.5kaAutumn)
ncin15.5spr <- nc_open(ncfname15.5kaSpring)
ncin15.5win <- nc_open(ncfname15.5kaWinter)
ncin15.5sum <- nc_open(ncfname15.5kaSummer)

ncin15 <- nc_open(ncfname15ka)
ncin15aut <- nc_open(ncfname15kaAutumn)
ncin15spr <- nc_open(ncfname15kaSpring)
ncin15win <- nc_open(ncfname15kaWinter)
ncin15sum <- nc_open(ncfname15kaSummer)

ncin14.5 <- nc_open(ncfname14.5ka)
ncin14.5aut <- nc_open(ncfname14.5kaAutumn)
ncin14.5spr <- nc_open(ncfname14.5kaSpring)
ncin14.5win <- nc_open(ncfname14.5kaWinter)
ncin14.5sum <- nc_open(ncfname14.5kaSummer)

#write values to array

tmp_array17 <- ncvar_get(ncin17,dname)
tmp_array17win <- ncvar_get(ncin17win,dname)
tmp_array17sum <- ncvar_get(ncin17sum,dname)
tmp_array17spr <- ncvar_get(ncin17spr,dname)
tmp_array17aut <- ncvar_get(ncin17aut,dname)


tmp_array16 <- ncvar_get(ncin16,dname)
tmp_array16win <- ncvar_get(ncin16win,dname)
tmp_array16sum <- ncvar_get(ncin16sum,dname)
tmp_array16spr <- ncvar_get(ncin16spr,dname)
tmp_array16aut <- ncvar_get(ncin16aut,dname)


tmp_array15.5 <- ncvar_get(ncin15.5,dname)
tmp_array15.5win <- ncvar_get(ncin15.5win,dname)
tmp_array15.5sum <- ncvar_get(ncin15.5sum,dname)
tmp_array15.5spr <- ncvar_get(ncin15.5spr,dname)
tmp_array15.5aut <- ncvar_get(ncin15.5aut,dname)


tmp_array15 <- ncvar_get(ncin15,dname)
tmp_array15win <- ncvar_get(ncin15win,dname)
tmp_array15sum <- ncvar_get(ncin15sum,dname)
tmp_array15spr <- ncvar_get(ncin15spr,dname)
tmp_array15aut <- ncvar_get(ncin15aut,dname)


tmp_array14.5 <- ncvar_get(ncin14.5,dname)
tmp_array14.5win <- ncvar_get(ncin14.5win,dname)
tmp_array14.5sum <- ncvar_get(ncin14.5sum,dname)
tmp_array14.5spr <- ncvar_get(ncin14.5spr,dname)
tmp_array14.5aut <- ncvar_get(ncin14.5aut,dname)

#close each .nc file
#write values to array

nc_close(ncin17)
nc_close(ncin17aut)
nc_close(ncin17spr)
nc_close(ncin17sum)
nc_close(ncin17win)
nc_close(ncin16)
nc_close(ncin16aut)
nc_close(ncin16spr)
nc_close(ncin16sum)
nc_close(ncin16win)
nc_close(ncin15.5)
nc_close(ncin15.5aut)
nc_close(ncin15.5spr)
nc_close(ncin15.5sum)
nc_close(ncin15.5win)
nc_close(ncin15)
nc_close(ncin15aut)
nc_close(ncin15spr)
nc_close(ncin15sum)
nc_close(ncin15win)
nc_close(ncin14.5)
nc_close(ncin14.5aut)
nc_close(ncin14.5spr)
nc_close(ncin14.5sum)
nc_close(ncin14.5win)

library(chron)
library(lattice)
library(RColorBrewer)

#upload ice shapefiles from Hughes et al. (2016)----
TS16<-'TS16_mc.shp'

paste(ncpath, TS21, sep="")
ncpath2 <- "/Volumes/Macintosh HD/Users/paullincoln/Documents/GitHub/Llangorse-sea-ice-code/DATED1 TimeSlices shp/"
library(rgdal)

TS17<-paste(ncpath, 'TS17_mc.shp', sep="")
i17ka <- readOGR(TS17)
i17ka <- spTransform(i17ka, CRSobj = "+proj=longlat")
TS16<-paste(ncpath, 'TS16_mc.shp', sep="")
i16ka <- readOGR(TS16)
i16ka <- spTransform(i16ka, CRSobj = "+proj=longlat")
TS15<-paste(ncpath, 'TS15_mc.shp', sep="")
i15ka <- readOGR(TS15)
i15ka <- spTransform(i15ka, CRSobj = "+proj=longlat")
TS14<-paste(ncpath, 'TS14_mc.shp', sep="")
i14ka <- readOGR(TS14)
i14ka <- spTransform(i14ka, CRSobj = "+proj=longlat")
lgm<-paste(ncpath, 'LGM_shapefiles.shp', sep="")
lgm <- readOGR(lgm)
lgm <- spTransform(lgm, CRSobj = "+proj=longlat")
alps<-paste(ncpath, 'Alps.shp', sep="")
alps <- readOGR(alps)
alps <- spTransform(alps, CRSobj = "+proj=longlat")

#plot outputs  ----
countries <-maps:: map("world", fill = T) 
cname <- countries$names
countries <- map2SpatialPolygons(countries, ID=cname, proj4string = CRS("+proj=longlat"))


# Set color palette for plot, this is only needed for the levelplots
zeroCol <-"#FFFFFF" # (gray color, same as your figure example)
reds <- brewer.pal('YlOrRd', n = 9)
blues <- rev(brewer.pal('Blues', n = 9))
ice <- c('lightblue', 'red', n=4)
greys <- brewer.pal('Greys', n=9)
cols <- hcl.colors(4, "YlOrRd")
cols = rev(colorRampPalette(c('darkred','red','blue','lightblue'))(10))
myTheme <- rasterTheme(region = c(blues, zeroCol, reds)) #red is warm blue is cold
mytheme2 <- rasterTheme(region = c(blues))
depth.col <- level.colors(tmp_array17, at = cutsptseries2,col.regions = terrain.colors)

# levelplot of the slice
grid <- expand.grid(lon=lonc, lat=lat)
cutpts <- c(-50,-40,-30,-20,-10,0,10,20,30,40,50)
cutpts <- c(9,8, 7, 6, 5, 4, 3, 2, 1, 0.000000001, -0.000000001, -1, -2, -3, -4, -5, -6, -7, -8, -9)
cutpts <- c(7, 6.5, 6, 5.5, 5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1, 0.00000000001, -0.00000000001, -1, -1.5, -2, -2.5, -3, -3.5, -4, -4.5, -5, -5.5, -6, -6.5, -7)
cutptscon <- c(0.3)
cutptsconseries <- c(0.25, 0.5, 0.75, 1)
cutsptseries2 <- seq(0,1,0.1)

#multiple contours
require(gridExtra) # also loads grid
require(lattice)
plot17 <- contourplot(tmp_array17 ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '17ka',col = 'blue') +
  latticeExtra::layer(sp.polygons(countries, fill = 'grey')) +
  latticeExtra::layer(sp.polygons(i17ka, fill = 'white')) + 
  latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +
  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9))

plot16<-contourplot(tmp_array16 ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '16ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15.5 <-contourplot(tmp_array15.5 ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15 <- contourplot(tmp_array15 ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i15ka, fill = 'white'))+latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot14.5 <-contourplot(tmp_array14.5 ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '14.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i14ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 

#multiplot of sea ice timestep
print(plot17, split = c(1, 1, 2, 3), more = TRUE)
print(plot16, split = c(2, 1, 2, 3), more = TRUE)
print(plot15.5, split = c(1, 2, 2, 3), more = TRUE)
print(plot15, split = c(2, 2, 2, 3), more = TRUE)  
print(plot14.5, split = c(1, 3, 2, 3), more = FALSE)  

#seasons

#Spring ----
plot17 <- contourplot(tmp_array17spr ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '17ka',col = 'blue')
+ latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i17ka, fill = 'white'))
+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) 
+ latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9))

plot16<-contourplot(tmp_array16spr ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '16ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15.5 <-contourplot(tmp_array15.5spr ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15 <- contourplot(tmp_array15spr ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i15ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot14.5 <-contourplot(tmp_array14.5spr ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '14.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i14ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 

#multiplot of sea ice timestep
print(plot17, split = c(1, 1, 2, 3), more = TRUE)
print(plot16, split = c(2, 1, 2, 3), more = TRUE)
print(plot15.5, split = c(1, 2, 2, 3), more = TRUE)
print(plot15, split = c(2, 2, 2, 3), more = TRUE)  
print(plot14.5, split = c(1, 3, 2, 3), more = FALSE)  

#Summer ----
plot17 <- contourplot(tmp_array17sum ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '17ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i17ka, fill = 'white')) + latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9))
plot16<-contourplot(tmp_array16sum ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '16ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15.5 <-contourplot(tmp_array15.5sum ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15 <- contourplot(tmp_array15sum ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i15ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot14.5 <-contourplot(tmp_array14.5sum ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '14.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i14ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 

#multiplot of sea ice timestep
print(plot17, split = c(1, 1, 2, 3), more = TRUE)
print(plot16, split = c(2, 1, 2, 3), more = TRUE)
print(plot15.5, split = c(1, 2, 2, 3), more = TRUE)
print(plot15, split = c(2, 2, 2, 3), more = TRUE)  
print(plot14.5, split = c(1, 3, 2, 3), more = FALSE)  

#Autumn ----
plot17 <- contourplot(tmp_array17aut ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '17ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i17ka, fill = 'white')) + latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9))
plot16<-contourplot(tmp_array16aut ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '16ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15.5 <-contourplot(tmp_array15.5aut ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15 <- contourplot(tmp_array15aut ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i15ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot14.5 <-contourplot(tmp_array14.5aut ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '14.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i14ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 

#multiplot of sea ice timestep
print(plot17, split = c(1, 1, 2, 3), more = TRUE)
print(plot16, split = c(2, 1, 2, 3), more = TRUE)
print(plot15.5, split = c(1, 2, 2, 3), more = TRUE)
print(plot15, split = c(2, 2, 2, 3), more = TRUE)  
print(plot14.5, split = c(1, 3, 2, 3), more = FALSE)  

#Winter ----
plot17 <- contourplot(tmp_array17win ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '17ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i17ka, fill = 'white')) + latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9))
plot16<-contourplot(tmp_array16win ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5,main = '16ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15.5 <-contourplot(tmp_array15.5win ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i16ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.9)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot15 <- contourplot(tmp_array15win ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '15ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i15ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 
plot14.5 <-contourplot(tmp_array14.5win ~ lon * lat, data=grid, at = cutsptseries2, cuts = 5, xlim=c(-45,30), ylim=c(40,76), region = T,  pretty=T, par.settings = mytheme2, alpha.regions= 0.5, main = '14.5ka',col = 'blue') + latticeExtra::layer(sp.polygons(countries, fill = 'grey')) + latticeExtra::layer(sp.polygons(i14ka, fill = 'white'))+ latticeExtra::layer(sp.polygons(lgm, fill = 'white', alpha = 0.5)) +  latticeExtra::layer(sp.polygons(alps, fill = 'white', alpha = 0.9)) 

#multiplot of sea ice timestep
print(plot17, split = c(1, 1, 2, 3), more = TRUE)
print(plot16, split = c(2, 1, 2, 3), more = TRUE)
print(plot15.5, split = c(1, 2, 2, 3), more = TRUE)
print(plot15, split = c(2, 2, 2, 3), more = TRUE)  
print(plot14.5, split = c(1, 3, 2, 3), more = FALSE)  
