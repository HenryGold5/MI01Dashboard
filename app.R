# MI01 Dashboard Landing Page
# Shiny app for Posit Connect Cloud deployment

library(shiny)
library(bslib)

# Function to discover QMD dashboards in the directory
discover_dashboards <- function() {
  qmd_files <- list.files(pattern = "\\.qmd$", full.names = FALSE)

  # Create dashboard info list
  dashboards <- lapply(qmd_files, function(file) {
    # Extract title from filename (remove .qmd and format)
    title <- gsub("\\.qmd$", "", file)
    title <- gsub("([a-z])([A-Z])", "\\1 \\2", title)  # Add spaces between camelCase

    list(
      file = file,
      title = title,
      description = paste("Interactive dashboard:", title)
    )
  })

  # Add manual descriptions for known dashboards
  for (i in seq_along(dashboards)) {
    if (dashboards[[i]]$file == "CountyOutputDashboard.qmd") {
      dashboards[[i]]$title <- "County Output Dashboard"
      dashboards[[i]]$description <- "Michigan District 1 county analysis with voting, education, jobs, veterans, and demographic data"
    }
  }

  dashboards
}

# UI
ui <- page_navbar(
  title = "MI01 Dashboard Hub",
  theme = bs_theme(
    bootswatch = "journal",
    primary = "#0066cc",
    base_font = font_google("Open Sans")
  ),

  nav_panel(
    title = "Home",
    layout_columns(
      col_widths = c(12),

      # Header
      card(
        card_header(
          class = "bg-primary text-white",
          tags$h2("Michigan District 1 Dashboard Hub", class = "mb-0")
        ),
        card_body(
          tags$p(
            class = "lead",
            "Welcome to the MI01 Dashboard Hub. Access interactive data visualizations and analysis tools for Michigan's 1st Congressional District."
          ),
          tags$hr(),
          tags$p(
            "This platform provides comprehensive insights into voting patterns, education, employment, veterans affairs, and demographic trends across District 1 counties."
          )
        )
      ),

      # Dashboard Cards
      uiOutput("dashboard_cards")
    )
  ),

  nav_panel(
    title = "About",
    layout_columns(
      col_widths = c(12),
      card(
        card_header("About This Platform"),
        card_body(
          tags$h4("Data Sources"),
          tags$p("This dashboard aggregates data from multiple sources including:"),
          tags$ul(
            tags$li("County voting results and turnout data"),
            tags$li("Veterans Administration spending records"),
            tags$li("County employment and business establishment statistics"),
            tags$li("Demographic data (age, education, income, race/ethnicity)"),
            tags$li("Geographic boundary data for counties, precincts, and metro areas")
          ),
          tags$hr(),
          tags$h4("Features"),
          tags$ul(
            tags$li("Interactive county-level analysis"),
            tags$li("Geographic visualizations with mapping"),
            tags$li("Comparative statistics across multiple dimensions"),
            tags$li("Responsive design for desktop and mobile viewing")
          ),
          tags$hr(),
          tags$p(
            tags$em("Deployed on Posit Connect Cloud from GitHub"),
            class = "text-muted"
          )
        )
      )
    )
  ),

  nav_spacer(),

  nav_item(
    tags$a(
      href = "https://github.com",
      target = "_blank",
      icon("github"),
      "GitHub"
    )
  )
)

# Server
server <- function(input, output, session) {

  # Discover available dashboards
  dashboards <- discover_dashboards()

  # Render dashboard cards
  output$dashboard_cards <- renderUI({

    if (length(dashboards) == 0) {
      return(
        card(
          card_body(
            tags$p("No dashboards found. Please add .qmd files to the repository.", class = "text-muted")
          )
        )
      )
    }

    # Create a card for each dashboard
    dashboard_cards <- lapply(dashboards, function(dash) {
      # Create the URL for the dashboard
      # For Posit Connect, we'll use relative paths
      dashboard_name <- gsub("\\.qmd$", "", dash$file)

      card(
        card_header(
          class = "bg-light",
          tags$h4(dash$title, class = "mb-0")
        ),
        card_body(
          tags$p(dash$description),
          tags$p(
            actionButton(
              inputId = paste0("btn_", dashboard_name),
              label = "Open Dashboard",
              icon = icon("chart-line"),
              class = "btn-primary",
              onclick = sprintf("window.open('%s.html', '_blank')", dashboard_name)
            ),
            tags$a(
              href = dash$file,
              target = "_blank",
              class = "btn btn-outline-secondary ms-2",
              icon("code"),
              "View Source"
            )
          )
        ),
        card_footer(
          class = "text-muted small",
          tags$em(paste("File:", dash$file))
        )
      )
    })

    # Return all cards
    tagList(dashboard_cards)
  })

}

# Run the application
shinyApp(ui = ui, server = server)
