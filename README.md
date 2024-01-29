# {MSProfileR}

Application de traitement de spectres
  
  
***
  
  
### 1) What is {MSProfileR}?

Insert package description

### 2) Installation

```
#Install from CRAN 
#Not currently on CRAN

  
#Install the development version from GitHub  
install.packages("devtools")

#Install MSProfileR
devtools::install_github("HugoMrth/MSProfileR", upgrade = "never", build_vignettes = TRUE)

#Vignette installation may not work, in that case run the following :
devtools::install_github("HugoMrth/MSProfileR", upgrade = "never")

#R may recquire a session restart in order to properly run the App : Ctrl + Shift + F10
```

### 3) Usage

```{r}
library(MSProfileR)

#Access to the application guide
browseVignettes(package = "MSProfileR")
#Launch the App
runMSProfileR()
```
