library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analyzing Motortrends Car Data and building a linear regression model"),
  
  h3("Introduction"),
  p("This application helps analyzing the mtcars data set from R and helps building a linear regression model."),
  p("In the first part, 2-3 variables can be chosen to be plotted in a 2D Scatterplot. 
    In the second part, linear regression models can be build by selecting the outcome and the predictors."),
  
  h3("1. Analyzing the variables and their relationships"),
  p("Before starting to think about a regression model, the variables need to be explored. 
    This part of the application helps. Variables for the x and y axis can be picked. 
    Optionally, a categorcial variables can be chosen es well. The data points will then 
    be colored according to their value of that category."),
  p("Additionally, the plot also shows a linar regression line with prediction interval 
    for the selected variables. If a category was chosen, then the line will be shown for 
    each category individually (if there are enough values within that category)."),
  
  # Sidebar with a selectInput for two variables
  sidebarLayout(
    sidebarPanel(
        h4("Choose variables to analyze on:"),
                
        selectInput("select_x",
                    "Select Variable for X Axis:",
                    choices=c("1/4 mile time" = "qsec",
                              "Cylinder" = "cyl",
                              "Dispension" = "disp",
                              "Horse Power" = "hp",
                              "Miles per (US) Gallon" = "mpg",
                              "Number of Carburetors" = "carb",
                              "Number of forward Gears" = "gear",
                              "Rear Axle Ratio" = "drat",
                              "Transmission" = "am",
                              "V/S" = "vs",
                              "Weight (1000lbs)" = "wt"),
                    selected="hp"),
        selectInput("select_y",
                    "Select Variable for Y Axis:",
                    choices=c("1/4 mile time" = "qsec",
                              "Cylinder" = "cyl",
                              "Dispension" = "disp",
                              "Horse Power" = "hp",
                              "Miles per (US) Gallon" = "mpg",
                              "Number of Carburetors" = "carb",
                              "Number of forward Gears" = "gear",
                              "Rear Axle Ratio" = "drat",
                              "Transmission" = "am",
                              "V/S" = "vs",
                              "Weight (1000lbs)" = "wt"),
                    selected="mpg"),
        selectInput("select_col",
                    "Categorize by:",
                    choices=c("None" = "none",
                            "Cylinder" = "cyl",
                              "Number of Carburetors" = "carb",
                              "Number of forward Gears" = "gear",
                              "Transmission" = "am",
                              "V/S" = "vs"),
                    selected="none")
    ),
    
    # Show a plot of the two variables
    mainPanel(
        h4("Plotting the relationship between variables:"),
        plotOutput("var_plot")
    )
  ),
  
  h3("2. Building a linear model"),
  p("This part helps with building a linear regression model. First the outcome variable needs to decided on. 
    Then the predictors can be chosen. The summary of the resulting model is printed to the web page."),
  p("Hint: If the outcome variable is also selected as a predictor, it will be removed from the predictors' list."),
  
  sidebarLayout(
      sidebarPanel(
          h4("Choose variables for model:"),
          selectInput("select_out",
                      "Select Outcome::",
                      choices=c("1/4 mile time" = "qsec",
                                "Cylinder" = "cyl",
                                "Dispension" = "disp",
                                "Horse Power" = "hp",
                                "Miles per (US) Gallon" = "mpg",
                                "Number of Carburetors" = "carb",
                                "Number of forward Gears" = "gear",
                                "Rear Axle Ratio" = "drat",
                                "Transmission" = "am",
                                "V/S" = "vs",
                                "Weight (1000lbs)" = "wt"),
                      selected="mpg"),
          checkboxGroupInput("chkbox_pred", "Choose predictors:",
                             c("1/4 mile time" = "qsec",
                               "Cylinder" = "cyl",
                               "Dispension" = "disp",
                               "Horse Power" = "hp",
                               "Miles per (US) Gallon" = "mpg",
                               "Number of Carburetors" = "carb",
                               "Number of forward Gears" = "gear",
                               "Rear Axle Ratio" = "drat",
                               "Transmission" = "am",
                               "V/S" = "vs",
                               "Weight (1000lbs)" = "wt")
                             )
      ),
      mainPanel(
          h4("Linear Regression Model"),
          verbatimTextOutput("modelSummary")
      )
  )
))

