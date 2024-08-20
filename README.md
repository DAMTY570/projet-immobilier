# Analysis of the Impact of Real Estate Prices in City Centers on Their Peripheries

## Project Overview
This project focuses on analyzing how real estate prices in city centers influence the prices in their surrounding peripheries and rural areas. Using a contagion model, we examined the spread of price variations across different regions in France, based on data from 2010 to 2020.

### Key Objectives:
- Understand the impact of city center real estate prices on peripheral and rural areas.
- Develop indices to measure real estate prices across different regions.
- Utilize econometric models to estimate the contagion effect of price variations.

## Data
The data was sourced from the notary database **dv3f**, which includes all real estate transactions (both apartments and houses) in France between 2010 and 2020. The dataset contains over 7.7 million observations with 210 variables, covering transactions in major cities and their peripheries.

### Cities Analyzed:
- Paris
- Marseille
- Lyon
- Toulouse
- Nice
- Nantes
- Bordeaux
- Lille
- Rennes
- Toulon
- Cannes
- Aix
- Roubaix
- Tourcoing

## Methodology
1. **Price Indices Construction**: We constructed price indices for each city, its periphery, and the rural areas using a classical linear regression model (OLS). The reference models were built for both apartments and houses, based on various characteristics like the number of rooms, presence of a garage, and the year of construction.

2. **Contagion Model**: We applied a contagion model to analyze how price variations in city centers propagate to peripheral areas. The model used lagged variables to capture the temporal effects of price changes.

3. **Econometric Analysis**: We conducted multiple regressions to estimate the impact of city center prices on their peripheries and rural areas, and tested the significance of these effects across different regions.

## Results
- **City Center Influence**: We confirmed that city center prices have a significant impact on the prices in their peripheries, with varying degrees of influence depending on the region.
- **Rural Areas**: The impact of city center prices on rural areas was generally weaker compared to the peripheries, with some exceptions.
- **Regional Variations**: Paris showed the strongest contagion effect, where a 10% increase in city center prices resulted in a nearly equivalent increase in peripheral prices for apartments. In contrast, cities like Lille showed a much weaker influence.

## Technologies Used
- **Languages:** Python, R, SQL
- **Libraries:** Pandas, Numpy, Statsmodels, Matplotlib, Seaborn
- **Tools:** Jupyter Notebook, QGIS, Excel/VBA, VS Code

## Conclusion and Limitations
This study highlights the significant impact that city center real estate prices can have on surrounding areas, especially in large urban centers. However, the study also has limitations, particularly in the partitioning of France into regions, which was done manually due to computational constraints. Future work could improve on these methods by leveraging more sophisticated geographical partitioning techniques and incorporating additional factors.

## Authors
- **Youssef El Yaakoubi**
- **Krah Kouamé Damty Abraham**

## References
1. Bessone, A., Heitz, B., & Boissinot, J. (2005). Marché immobilier: voit-on une bulle? Note de conjoncture.
2. Grissom, T. V., Hartzell, D., & Liu, C. H. (1987). An approach to industrial real estate market segmentation and valuation using the arbitrage pricing paradigm. Real Estate Economics, 15(3), 199-219.
3. Moec, G., et al. (2004). Y at-il un risque de bulle immobilière en France? Bulletin de la Banque de France, (129), 45-58.
4. Osland, L. (2010). An application of spatial econometrics in relation to hedonic house price modeling. Journal of Real Estate Research, 32(3), 289-320.

