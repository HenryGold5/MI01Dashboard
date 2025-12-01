# MI01 Dashboard

> Interactive data analytics platform for Michigan's 1st Congressional District

[![Posit Connect](https://img.shields.io/badge/Deployed%20on-Posit%20Connect%20Cloud-blue)](https://posit.co/products/cloud/connect/)
[![Quarto](https://img.shields.io/badge/Made%20with-Quarto-75AADB.svg)](https://quarto.org)
[![R Shiny](https://img.shields.io/badge/Built%20with-R%20Shiny-276DC3.svg)](https://shiny.rstudio.com/)

## Overview

MI01 Dashboard is a comprehensive analytics platform providing interactive visualizations and insights into voting patterns, demographics, employment, education, and veterans affairs across Michigan's 1st Congressional District.

### Features

- 🗳️ **Voting Analysis**: County-wide and precinct-level election results and turnout data
- 👥 **Demographics**: Age, race, income, and education profiles by county
- 💼 **Employment**: Jobs, establishments, and payroll statistics
- 🎓 **Education**: School district data and performance metrics
- 🎖️ **Veterans**: VA spending and services data
- 🗺️ **Geographic Visualization**: Interactive maps with county and precinct boundaries

## Quick Start

### For Posit Connect Cloud Deployment

**Primary Method (Shiny App):**
1. In Posit Connect Cloud, click "Publish" → "From Git Repository"
2. Select this repository: `HenryGold5/MI01Dashboard`
3. Choose Content Type: **Shiny Application**
4. Set Primary File: `app.R`
5. Click Deploy

**Alternative Method (Quarto Website):**
1. In Posit Connect Cloud, click "Publish" → "From Git Repository"
2. Select this repository
3. Choose Content Type: **Quarto Website**
4. Posit Connect will auto-detect `_quarto.yml` and `index.qmd`
5. Click Deploy

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions.

### Local Development

```bash
# Clone the repository
git clone https://github.com/HenryGold5/MI01Dashboard.git
cd MI01Dashboard

# Open in RStudio or run:
Rscript -e "shiny::runApp('app.R')"

# Or render the Quarto website:
quarto render
```

## Repository Structure

```
MI01Dashboard/
├── app.R                          # 🎯 Primary Shiny app (landing page)
├── index.qmd                      # 📄 Alternative Quarto landing page
├── CountyOutputDashboard.qmd      # 📊 Interactive county dashboard
├── _quarto.yml                    # ⚙️ Quarto website configuration
├── manifest.json                  # 📦 Posit Connect deployment manifest
├── .Rprofile                      # 🔧 R environment setup
├── .gitignore                     # 🚫 Git ignore rules
├── DEPLOYMENT.md                  # 📘 Deployment guide
├── README.md                      # 📖 This file
└── data/
    ├── ExcelFiles/               # 📈 County statistics (13 .rds files)
    │   ├── votingResultsCountyWide.rds
    │   ├── voterTurnout2024.rds
    │   ├── spendDataVA.rds
    │   ├── numEmployeesCounty.rds
    │   ├── numEstablishmentsCounty.rds
    │   ├── payRollCounty.rds
    │   └── CountyDemographics_*.rds (7 files)
    └── Shapefiles/               # 🗺️ Geographic boundaries (5 .rds files)
        ├── district1Counties_lite.rds
        ├── district1Presincts_lite.rds
        ├── district1Metro_lite.rds
        ├── district1Overall_lite.rds
        └── educationDataset_lite.rds
```

## Dashboards

### County Output Dashboard
Interactive analysis of Michigan District 1 counties featuring:
- **Voting**: Election results and turnout by county and precinct
- **Demographics**: Population characteristics (age, race, income, education)
- **Employment**: Jobs, establishments, and payroll data
- **Education**: School districts and performance metrics
- **Veterans**: VA spending and services
- **Maps**: Interactive geographic visualizations

**File**: `CountyOutputDashboard.qmd`

### Adding New Dashboards

The landing page automatically detects new `.qmd` files. To add a dashboard:

1. Create your Quarto dashboard (e.g., `MyNewDashboard.qmd`)
2. Ensure it has proper YAML frontmatter:
   ```yaml
   ---
   title: "My Dashboard"
   format: dashboard
   server: shiny
   ---
   ```
3. Commit and push to GitHub
4. The app.R landing page will automatically list it

## Data Sources

All data is pre-processed and stored as compressed RDS files:

- **Voting**: County/precinct election results and turnout
- **Veterans**: Department of Veterans Affairs spending records
- **Employment**: Bureau of Labor Statistics county business patterns
- **Demographics**: U.S. Census Bureau American Community Survey
- **Geography**: Census TIGER/Line shapefiles (simplified for web performance)

**Total data size**: ~620 KB (compressed)

## Technology Stack

- **Framework**: [Quarto](https://quarto.org) + [R Shiny](https://shiny.rstudio.com/)
- **UI**: [bslib](https://rstudio.github.io/bslib/) (Bootstrap 5)
- **Mapping**: [tmap](https://r-tmap.github.io/tmap/), [sf](https://r-spatial.github.io/sf/)
- **Data**: [dplyr](https://dplyr.tidyverse.org/), [tidyr](https://tidyr.tidyverse.org/)
- **Visualization**: [ggplot2](https://ggplot2.tidyverse.org/), [gt](https://gt.rstudio.com/)
- **Deployment**: [Posit Connect Cloud](https://posit.co/products/cloud/connect/)

## R Package Dependencies

```r
# Core
shiny, bslib, quarto

# Data manipulation
dplyr, tidyr, stringr, readxl

# Visualization
ggplot2, scales, gt, gtExtras

# Geospatial
tmap, sf, cartogram
```

See `.Rprofile` for automatic package installation.

## Development

### Prerequisites

- R ≥ 4.1.0
- Quarto ≥ 1.3.0
- RStudio (recommended)

### Setup

```r
# Install required packages
install.packages(c(
  "shiny", "bslib", "dplyr", "tmap", "sf", "cartogram",
  "gt", "gtExtras", "stringr", "ggplot2", "scales",
  "tidyr", "readxl", "quarto"
))

# Run the Shiny app
shiny::runApp("app.R")

# Or render the Quarto website
quarto::quarto_render()
```

### Testing Locally

```bash
# Run Shiny app
Rscript -e "shiny::runApp('app.R', port=8888)"

# Render Quarto site
quarto render
quarto preview
```

## Deployment Options

### Option 1: Shiny App (app.R) ⭐ Recommended

The Shiny app provides a dynamic landing page that auto-discovers dashboards.

**Pros:**
- Interactive landing page
- Auto-discovery of new dashboards
- Real-time rendering
- Full Shiny capabilities

**Cons:**
- Slightly higher resource usage
- Requires Shiny Server

### Option 2: Quarto Website (index.qmd + _quarto.yml)

A static website with links to dashboards.

**Pros:**
- Lighter weight
- Faster initial load
- Better for static content

**Cons:**
- Manual updates to add new dashboards
- Less interactive landing page

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions.

## Configuration

### Posit Connect Cloud Settings

When deploying from GitHub:

1. **Content Type**: Shiny Application (for app.R) or Quarto Website (for _quarto.yml)
2. **Primary File**: `app.R` or `index.qmd`
3. **Branch**: `claude/posit-connect-github-setup-01SBQiR52E57CGEE3wE7TM8g` (or your chosen branch)
4. **Auto-deploy**: Enable for automatic updates on push

### Environment Variables

No special environment variables required. All data is bundled.

## Troubleshooting

### Common Issues

**Package installation fails:**
- Check Posit Connect logs for specific errors
- Verify package availability on CRAN
- Consider using `renv` for reproducibility

**Dashboard doesn't render:**
- Ensure Quarto is available on the server
- Check YAML frontmatter in .qmd files
- Verify data file paths are relative

**Data files not found:**
- Ensure `data/` directory is committed to Git
- Check that paths use forward slashes: `data/ExcelFiles/file.rds`
- Verify .gitignore isn't excluding data files

See [DEPLOYMENT.md](DEPLOYMENT.md) for more troubleshooting tips.

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Test locally: `Rscript -e "shiny::runApp('app.R')"`
5. Commit: `git commit -am 'Add my feature'`
6. Push: `git push origin feature/my-feature`
7. Create a Pull Request

## License

[Add your license information here]

## Support

- **Documentation**: See [DEPLOYMENT.md](DEPLOYMENT.md)
- **Issues**: Open an issue on GitHub
- **Posit Connect**: [Posit Support](https://support.posit.co)

## Acknowledgments

Data sources:
- Michigan Secretary of State
- U.S. Census Bureau
- Bureau of Labor Statistics
- Department of Veterans Affairs

---

Made with ❤️ using [Quarto](https://quarto.org) and [R Shiny](https://shiny.rstudio.com/)
