library(shiny)
library(ggplot2)

data(mtcars)
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)

shinyServer(function(input, output) {
       
    lin_model <- reactive({
        
        out <- input$select_out
        preds <- input$chkbox_pred
        preds <- preds[!preds %in% out]
        
        if(length(preds) > 0) {
        
                model_formula = formula(paste(out, "~", paste(preds, collapse="+")))
                lm(model_formula, data=mtcars)
            
        } else {
           return(NULL) 
        }
    })
    
    output$var_plot <- renderPlot({

        x_var <- input$select_x
        y_var <- input$select_y
        col_var <- input$select_col

        if (col_var == "none") {
            g <- ggplot(mtcars, aes_string(x=x_var, y=y_var))
        } else {
            g <- ggplot(mtcars, aes_string(x=x_var, y=y_var, color=col_var))
        }

        g + geom_point() + geom_smooth(method="lm")

    })

    output$modelSummary <- renderPrint({
        if(!is.null(lin_model())) {
            summary(lin_model())
        } else {
            print("No predictors selected yet.")
        }
    })
})
