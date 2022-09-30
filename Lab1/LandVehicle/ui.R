library(shiny)

#object for recognizing
VectorObjectForRecognizing = c('Car', 'Motorcycle', 'Scooter', 'Bicycle') # value for prediction

#characteristics
VectorOfCharacteristicsNames = c('engine', 'no engine','two wheel', 'four wheel', 'weight > 1T', 'weight < 1T', '4 seats', '2 seats', '1 seat', 'ride standing up') # features
VectorOfCharacteristicsValues = c('engine', 'noEngine', 'twoWheel', 'fourWheel', 'weightBig', 'weightSmall', '4seats', '2seats', '1seat', 'RideStandingUp')

shinyUI(fluidPage(

    navbarPage("Land vehicle",
               
      tabPanel('Study',
        sidebarLayout(
            sidebarPanel(
              checkboxGroupInput(inputId = 'characterStd', 
                                 'Entrer value:',
                                 choiceNames = VectorOfCharacteristicsNames,
                                 choiceValues = VectorOfCharacteristicsValues,
              ),                    
              submitButton('Apply'),
            ),
            
            mainPanel(
                textOutput("choiceCharacterStd"),
                dataTableOutput('VehicleTableStd'),
            )
        )
    ),
    
    
    tabPanel('Prediction',
             sidebarLayout(
               sidebarPanel(
                 checkboxGroupInput(inputId = 'characterRec', 
                                    'Entrer value:',
                                    choiceNames = VectorOfCharacteristicsNames,
                                    choiceValues = VectorOfCharacteristicsValues
                 ),                    
                 submitButton('Apply')
               ),
               
               
               mainPanel(
                 textOutput("choiceCharacterRec"),
                 dataTableOutput('VehicleTableRec')
               )
             )
      ),
    )
))
