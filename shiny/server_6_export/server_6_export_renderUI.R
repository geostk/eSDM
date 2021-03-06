### renderUI code for Export Model Predictions tab


###############################################################################
### Model with coord system in which to export selected model predictions
output$export_proj_uiOut_select <- renderUI({
  req(vals$models.names)
  
  choices.list.names <- vals$models.names
  choices.list <- seq_along(choices.list.names)
  names(choices.list) <- choices.list.names
  
  selectInput("export_proj", 
              tags$h5("Export predictions in the coordinate system of the", 
                      "selected model predictions"), 
              choices = choices.list, selected = 1)
})


### Default filename of exported object
output$export_filename_uiOut_text <- renderUI({
  req(vals$models.ll)
  x <- input$export_table_orig_out_rows_selected
  y <- input$export_table_over_out_rows_selected
  z <- input$export_table_ens_out_rows_selected
  req(sum(!sapply(list(x, y, z), is.null)) == 1)
  
  ## Extract first term of filename
  if(!is.null(x)) {
    # Orig model predictions
    table.info <- table_orig()[x, ]
    
    filename.value <- paste(table.info[,1:2], collapse = "__")
    filename.value <- paste0(filename.value, "__orig")
  } else if (!is.null(y)) {
    # Overlaid model predictions
    table.info <- table_overlaid()[y, ]
    
    filename.value <- paste(table.info[,1:2], collapse = "__")
    filename.value <- paste0(filename.value, "__overlaid")
  } else {  # !is.null(z)
    # Ensemble model predictions
    table.info <- table_ensembles()[z, ]
    
    table.info$`Ensembling method` <- switch(table.info$`Ensembling method`, 
                                             "Unweighted" = "UnW", 
                                             "Weighted" = "W")
    
    rescale.txt <- table.info$`Rescaling method`
    rescale.txt <- ifelse(grepl("Abund", rescale.txt), 
                          paste0("Abund", 
                                 strsplit(rescale.txt, ": ")[[1]][2]), 
                          switch(rescale.txt, 
                                 "None" = "None", 
                                 "Normalization" = "Norm", 
                                 "Standardization" = "Stand", 
                                 "Sum to 1" = "Sumto1_"))
    table.info$`Rescaling method` <- rescale.txt
    
    filename.value <- paste(table.info[,c(1, 3:4)], collapse = "_")
    filename.value <- gsub(", ", "+", filename.value) # Handles columns 2 & 4
  }
  
  ## Projection info
  proj.txt <- ifelse(input$export_proj_ll, "_ll", "_proj")
  filename.value <- paste0(filename.value, proj.txt)
  
  ## Prefix and extensions
  filename.ext <- switch(
    input$export_format, 
    "1" = ".csv", "2" = ".shp", 
    "3" = ifelse(input$export_format_kml == 1, ".kml", ".kmz")
  )
  filename.value <- gsub("\\.", "_", filename.value)
  filename.value <- paste0("eSDM_", filename.value, filename.ext)
  
  
  ## textInput()
  textInput("export_filename", tags$h5("Filename"), value = filename.value)
})

###############################################################################
