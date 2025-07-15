# Airline Loyalty Program Analytics
  This project was completed as a **self-initiated, unguided project** to showcase my data analysis and storytelling skills using real-world business scenarios.

## Overview
A data analytics project analyzing the performance and impact of a promotional campaign run by *Northern Lights Air (NLA)*, a fictional Canadian airline, to boost loyalty program enrollments. The project leverages SQL and Power BI to uncover insights around customer behavior, campaign adoption, and overall membership trends.

## Problem Statement
In an effort to increase engagement in its loyalty program, Northern Lights Air ran a **promotional campaign between February and April 2018**. The company seeks to understand:
- Was the campaign effective in increasing new memberships?
- Which customer segments responded best to the campaign?
- Did the campaign lead to more flight activity?
- What kind of customers tend to cancel or stay?

## Project Goals:
Campaign Effectiveness:
Analyze whether the promotional campaign led to a measurable increase in loyalty program enrollments (gross and net).

Demographic Adoption Analysis:
Identify if the campaign was more successful among specific demographic groups (e.g., gender, education, salary).

Post-Campaign Flight Behavior:
Examine whether there was a rise in flight bookings during the summer (June–August) following the campaign, especially from newly enrolled members.

## Dataset Description
The dataset contains two main tables:

1. **Customer Loyalty History**  
   - Contains demographic and enrollment details of customers
   - Key columns: `loyalty_number`, `enrollment_type`, `salary`, `education`, `cancellation_year`, `CLV`, etc.

2. **Customer Flight Activity**  
   - Monthly flight-level activity for customers
   - Key columns: `total_flights`, `points_accumulated`, `points_redeemed`, `dollar_cost_points_redeemed`, etc.

📁 *Source:* Maven Analytics  
🗺️ *Region:* Canada  
🧪 *Time Period Analyzed:* January–December 2018

## Technologies / Tools Used

- **SQL (MySQL)** – For data cleaning, transformation, and analysis  
- **Power BI** – For interactive data visualization and dashboarding  
- **Excel** – For minor preprocessing and validation  

## Business Questions Answered

1. How many customers enrolled during the campaign period (Feb–Apr 2018)?
2. Was there a spike in total flights after the campaign?
3. What are the demographics of the customers who enrolled or cancelled?
4. What percentage of campaign enrollees cancelled later?
5. Which cities or provinces showed high loyalty program activity?
6. Who are the top 10 loyal customers and their points redemption behavior?
7. How did flight activity trend monthly (including rolling 3-month totals)?

## Key Insights

-  **Slight enrollment increase** in 2018 during campaign months, especially April
-  **Bachelor degree holders** and **single individuals** formed the largest enroller groups
-  **11.88%** of campaign enrollees eventually cancelled their membership
-  **Flight activity peaked post-campaign** (May–July), aligned with summer travel
-  **CLV was similar** for both campaign and standard enrollees, indicating limited added value

## Dashboard Preview

![Dashboard Screenshot]

> *An interactive Power BI dashboard summarizing campaign performance, customer segmentation, and flight activity trends.*

## Recommendations

- Promote future campaigns **closer to vacation months** (e.g. May–July) to boost travel activity.
- Improve campaign **awareness and targeting** — many customers joined late in April.
- Capture **cancellation reasons** during offboarding to identify drop-off points.

## Learnings & Takeaways

- Improved my **business thinking and SQL logic** with real-world KPIs
- Learned to build **story-driven dashboards** using Power BI
- Understood how to **clean, structure, and analyze** messy real-world data
- Practiced **demographic segmentation**, **rolling averages**, and **campaign evaluation**
- Learned to present insights in a **clear, business-friendly format**

## Project Structure

Airline_Loyalty_Program_Analytics/
├── Dataset/
│ ├── Customer_Loyalty_History.csv
│ ├── Customer_Flight_Activity.csv
├── SQL_Analysis/
├── PowerBI_Dashboard/
│ └── Airline_Loyalty_Report.pbix
├── Screenshots/
│ └── dashboard.png
├── README.md
