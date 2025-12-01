# MI01 Dashboard - Posit Connect Cloud Deployment Guide

## Overview

This repository contains a Shiny-based landing page (`app.R`) that serves as a hub for accessing multiple Quarto dashboards. The structure is optimized for deployment on Posit Connect Cloud using GitHub as the source.

## Repository Structure

```
MI01Dashboard/
├── app.R                          # Main Shiny landing page (PRIMARY ENTRY POINT)
├── CountyOutputDashboard.qmd      # Interactive county dashboard
├── manifest.json                  # Posit Connect deployment manifest
├── .Rprofile                      # Package management
├── data/
│   ├── ExcelFiles/               # County data files (13 .rds files)
│   └── Shapefiles/               # Geographic boundary data (5 .rds files)
└── DEPLOYMENT.md                 # This file
```

## Deployment Options

### Option 1: Deploy as Shiny App with Landing Page (Recommended)

This is the primary deployment method using `app.R` as the entry point.

**Steps:**

1. **In Posit Connect Cloud:**
   - Click "Publish" → "New Content"
   - Select "From Git Repository"
   - Choose "GitHub" as the source

2. **Configure Repository:**
   - Repository: `HenryGold5/MI01Dashboard`
   - Branch: `claude/posit-connect-github-setup-01SBQiR52E57CGEE3wE7TM8g` (or your desired branch)
   - Content Type: **Shiny Application**
   - Primary File: `app.R`

3. **Dependencies:**
   The following R packages will be automatically installed:
   - shiny, bslib (for landing page)
   - dplyr, tmap, sf, cartogram, gt, gtExtras (for dashboards)
   - stringr, ggplot2, scales, tidyr, readxl (data processing)
   - quarto (for rendering .qmd files)

4. **Deploy:**
   - Click "Deploy"
   - Wait for the initial deployment to complete
   - Your landing page will be accessible at the provided URL

### Option 2: Deploy QMD Dashboards Separately

If you want to deploy the Quarto dashboards as standalone content items:

**For each .qmd file:**

1. In Posit Connect Cloud:
   - Click "Publish" → "New Content"
   - Select "From Git Repository"
   - Choose the same repository
   - Content Type: **Quarto Document**
   - Primary File: `CountyOutputDashboard.qmd`

2. Update the landing page (`app.R`) to link to the deployed dashboard URLs

3. Modify the `onclick` handlers in `app.R` to point to the actual Posit Connect URLs

## Environment Variables

No special environment variables are required. All data files are included in the repository as `.rds` files.

## Data Files

All data dependencies are included in the repository:

- **ExcelFiles/**: County-level statistics (voting, employment, demographics)
- **Shapefiles/**: Geographic boundaries for mapping

Total data size: ~620 KB (compressed RDS format)

## Adding New Dashboards

To add a new dashboard to the landing page:

1. **Create a new .qmd file** in the root directory:
   ```
   NewDashboard.qmd
   ```

2. **The landing page will automatically detect it** using the `discover_dashboards()` function

3. **Customize the title and description** (optional):
   Edit the `discover_dashboards()` function in `app.R`:
   ```r
   if (dashboards[[i]]$file == "NewDashboard.qmd") {
     dashboards[[i]]$title <- "Your Dashboard Title"
     dashboards[[i]]$description <- "Description here"
   }
   ```

4. **Commit and push** to GitHub:
   ```bash
   git add NewDashboard.qmd app.R
   git commit -m "Add new dashboard"
   git push origin <branch-name>
   ```

5. **Redeploy** on Posit Connect Cloud (or enable auto-deploy from Git)

## Updating Content

### Manual Updates

1. Make changes to your files locally
2. Commit and push to GitHub
3. In Posit Connect Cloud, click "Update" on your deployed content

### Automatic Updates (Recommended)

1. In Posit Connect Cloud, go to your deployed app settings
2. Enable "Auto-deploy from Git"
3. Set the branch to monitor (e.g., `main` or your development branch)
4. Posit Connect will automatically redeploy when you push changes

## Troubleshooting

### Package Installation Issues

If packages fail to install:
- Check the deployment logs in Posit Connect Cloud
- Verify all packages are available on CRAN
- Consider adding a `renv.lock` file for reproducible environments

### QMD Files Not Rendering

If Quarto dashboards don't render:
1. Ensure Quarto is installed on Posit Connect Cloud (it should be by default)
2. Check that the YAML header in your .qmd file includes:
   ```yaml
   format:
     dashboard:
       theme: journal
   server: shiny
   ```
3. Verify all data file paths are correct relative to the project root

### Data Files Not Found

If you see "file not found" errors:
- All data paths should be relative: `data/ExcelFiles/filename.rds`
- Ensure the `data/` directory structure is preserved in Git
- Check that `.gitignore` is not excluding data files

## GitHub Actions (Optional)

For automated testing before deployment, you can add a `.github/workflows/check.yml` file:

```yaml
name: R Package Check
on: [push, pull_request]
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: r-lib/actions/setup-r@v2
      - name: Install dependencies
        run: |
          install.packages(c("shiny", "bslib", "quarto"))
        shell: Rscript {0}
      - name: Check app.R
        run: |
          if (!file.exists("app.R")) stop("app.R not found")
        shell: Rscript {0}
```

## Support

For issues with:
- **Posit Connect Cloud**: Contact Posit Support or check [docs.posit.co](https://docs.posit.co)
- **This Repository**: Open an issue on GitHub

## License

[Add your license information here]
