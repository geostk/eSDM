### Hide and show output plots using the shinyjs package


###############################################################################
# This is done because even if new predictions are loaded/created, the
# reactive functions still store and plot/display old information. Thus, 
# this code hides that old information until new, updated info is generated.


# The following must be done so that these plots render to NULL and thus 
# shinycssloaders spinner isn't shown. 
outputOptions(output, "model_pix_preview_plot", suspendWhenHidden = FALSE)
outputOptions(output, "overlay_preview_base", suspendWhenHidden = FALSE)
outputOptions(output, "overlay_preview_overlaid", suspendWhenHidden = FALSE)
outputOptions(output, "create_ens_weights_poly_preview_plot", 
              suspendWhenHidden = FALSE)
outputOptions(output, "ens_pix_preview_plot", suspendWhenHidden = FALSE)
outputOptions(output, "pretty_plot_plot", suspendWhenHidden = FALSE)


###############################################################################
# Show elements when their respective 'execute' buttons are clicked

### Show original model predictions preview
observeEvent(input$model_pix_preview_execute, {
  shinyjs::show("model_pix_preview_plot", time = 0)
})

### Show base grid preview
observeEvent(input$overlay_preview_base_execute, {
  shinyjs::show("overlay_preview_base", time = 0)
})

### Show overlaid model predictions preview
observeEvent(input$overlay_preview_overlaid_execute, {
  shinyjs::show("overlay_preview_overlaid", time = 0)
})

### Show overlaid model + weight polygon preview
observeEvent(input$create_ens_weights_poly_preview_execute, {
  shinyjs::show("create_ens_weights_poly_preview_plot", time = 0)
})


### Show 'ensemble created' message when ensemble is created
observeEvent(input$create_ens_create_action, {
  shinyjs::show("ens_create_ensemble_text", time = 0)
})

### Show ensemble model predictions preview
observeEvent(input$ens_preview_execute, {
  shinyjs::show("ens_pix_preview_plot", time = 0)
})

### Show pretty plot
observeEvent(input$pretty_plot_execute, {
  shinyjs::show("pretty_plot_plot", time = 0)
})


###############################################################################
### Hide elements when 'create overlaid models' button is clicked
observeEvent(input$overlay_create_overlaid_models, {
  shinyjs::hide("overlay_preview_overlaid", time = 0)
  shinyjs::hide("create_ens_weights_poly_preview_plot", time = 0)
  shinyjs::hide("ens_create_ensemble_text", time = 0)
  shinyjs::hide("ens_pix_preview_plot", time = 0)
  shinyjs::hide("pretty_plot_plot", time = 0) # Make this more robust so it only happens when an overlaid or ensemble model is plotted
})


###############################################################################
### Hide elements when a saved environment is loaded
observeEvent(input$load_app_envir_file, {
  shinyjs::hide("model_pix_preview_plot", time = 0)
  shinyjs::hide("overlay_preview_base", time = 0)
  shinyjs::hide("overlay_preview_overlaid", time = 0)
  shinyjs::hide("create_ens_weights_poly_preview_plot", time = 0)
  shinyjs::hide("ens_create_ensemble_text", time = 0)
  shinyjs::hide("ens_pix_preview_plot", time = 0)
  shinyjs::hide("pretty_plot_plot", time = 0)
})

###############################################################################
