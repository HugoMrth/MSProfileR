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

#Package not private anymore
#devtools::install_github("HugoMrth/MSProfileR", auth_token = "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", build_vignettes = TRUE)
#Install if public repository
devtools::install_github("HugoMrth/MSProfileR", build_vignettes = TRUE)
```

### 3) Usage


```{r}
library(MSProfileR)

#Access to the application guide
browseVignettes(package = "MSProfileR")
#Launch the App
runMSProfileR()
```
