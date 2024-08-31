# Governance in Haiti - Shiny App

## Overview

The **Governance in Haiti** Shiny app provides an interactive platform to explore and analyze the governance scores of political figures in Haiti. Using data that includes names, cities of birth, governance scores, and other relevant metrics, the app allows users to gain insights into governance quality across different regions and political figures. The live App is available here: https://stepminer.shinyapps.io/Haiti_politicians_governance/

## Features

- **Interactive Map**: Visualize the governance scores of political figures across Haiti using an interactive map. The map displays markers for each political figure's city of birth, with additional details available on hover or click.
- **Dynamic Bar Graph**: A bar graph displaying governance scores with a gradient color scale from light green (indicating low scores) to dark green (indicating high scores), providing a quick visual representation of governance quality.
- **Data Filtering**: Users can filter the data by political figure, city of birth, and other attributes to customize their view and focus on specific data subsets.

## Installation

To run this app locally, you'll need to have R and the following packages installed:

```R
install.packages(c('shiny', 'dplyr', 'leaflet', 'ggplot2', 'RColorBrewer', 'tibble'))
```

## Usage

1. Clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/governance-haiti-shiny-app.git
```

2. Open the app directory in RStudio or your preferred R environment.

3. Run the Shiny app using the following command:

```R
shiny::runApp('governance-haiti-shiny-app')
```

4. Use the app interface to explore governance scores by interacting with the map and bar graph. Adjust the filters to narrow down the data to specific figures or regions.

## Data Source

The data for this app is sourced from 'HTI_governance_geo.csv', which includes information on political figures' names, cities of birth, governance scores, and additional geographic coordinates.

## Contributing

Contributions to this project are welcome. If you'd like to contribute, please fork the repository, create a new branch, and submit a pull request with your changes.

## Feedback

If you encounter any issues or have suggestions for improvements, please open an issue in this repository or contact us directly via email.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

