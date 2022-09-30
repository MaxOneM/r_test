library(shiny)
library(tidyverse)

VectorOfCharacteristicsValues = c('engine', 'noEngine', 'twoWheel', 'fourWheel', 'weightBig', 'weightSmall', '4seats', '2seats', '1seat', 'RideStandingUp')

#read csv file `vehicleTab` and save in VehTab
VehTab <- data.frame(read.csv(file = 'data/VehicleTab.csv'))

#check characteristic
checkToNum <- function (fullCharect, checkCharect)
{
  return(as.numeric(fullCharect %in% checkCharect))
}


shinyServer(function(input, output) {
  
# get list with num values  
  getBoolCheckValStd <- reactive({
    boolCheckVal <- list(checkToNum(VectorOfCharacteristicsValues,input$characterStd))
    boolCheckVal <- boolCheckVal[[1]]
    boolCheckVal
  })
  
  VehTable <- reactive({
    VehTab$Answer <- getBoolCheckValRec()[c(1, 5, 7, 4, 1, 6, 8, 3, 2, 6, 10, 3, 2, 6, 9, 3)]
    VehTab <- mutate(VehTab, Total = Factor * Answer)
    VehTab
  })
  
  VehTableStd <- reactive({
    VehTab$Answer <- getBoolCheckValStd()[c(1, 5, 7, 4, 1, 6, 8, 3, 2, 6, 10, 3, 2, 6, 9, 3)]
    VehTab <- mutate(VehTab, Total = Factor * Answer)
    VehTab
  })
  
  SumCar <- reactive({sum(VehTable()$Total[1:4])}) 
  SumMotorcycle <- reactive({sum(VehTable()$Total[4:8])})
  SumScooter <- reactive({sum(VehTable()$Total[8:12])})
  SumBicycle <- reactive({sum(VehTable()$Total[12:16])})
  
  SumCarStd <- reactive({sum(VehTableStd()$Total[1:4])}) 
  SumMotorcycleStd <- reactive({sum(VehTableStd()$Total[4:8])})
  SumScooterStd <- reactive({sum(VehTableStd()$Total[8:12])})
  SumBicycleStd <- reactive({sum(VehTableStd()$Total[12:16])})
  
  getBoolCheckValRec <- reactive({
    boolCheckVal <- list(checkToNum(VectorOfCharacteristicsValues,input$characterRec))
    boolCheckVal <- boolCheckVal[[1]]
    boolCheckVal
  })
  

# Study -------------------------------------------------------------------

    output$VehicleTableStd <- renderDataTable({
      # VehTab<- cbind(VehTab, getBoolCheckVal()[c(1, 5, 7, 4, 1, 6, 8, 3, 2, 6, 10, 3, 2, 6, 9, 3)])
      VehTab$Answer <- getBoolCheckValStd()[c(1, 5, 7, 4, 1, 6, 8, 3, 2, 6, 10, 3, 2, 6, 9, 3)]
      VehTab <- mutate(VehTab, Total = Factor * Answer)
      VehTab
    })
    
    output$choiceCharacterStd <- renderText({
      # getBoolCheckValStd()
      if(sum(VehTableStd()$Total) > 0){c('Car', 'Motorcycle', 'Scooter', 'Bicycle')[which.max(c(SumCarStd(), SumMotorcycleStd(), SumScooterStd(), SumBicycleStd()))]}
    })
    

# Prediction --------------------------------------------------------------

    
    output$VehicleTableRec <- renderDataTable({
      VehTable()
    })
    
    output$choiceCharacterRec <- renderText({
      if(sum(VehTable()$Total) > 0){c('Car', 'Motorcycle', 'Scooter', 'Bicycle')[which.max(c(SumCar(), SumMotorcycle(), SumScooter(), SumBicycle()))]}
    })
    
})
