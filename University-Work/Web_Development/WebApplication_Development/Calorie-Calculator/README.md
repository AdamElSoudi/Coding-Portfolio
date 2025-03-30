# Calorie Calculator Website

This is the final project for my Web Application Development course. My project involved creating a calorie calculator website that allows users to search for food items and retrieve their nutritional values such as calories, protein, fat, sodium, and more.

## Pages

The website consists of 5 HTML pages:

1. **Home**: The landing page of the website.
2. **Calculator**: The main page where users can search for food items and view their nutritional information. 
3. **Information**: Provides information about the calorie calculator and its features.
4. **Ready Meals**: Displays a list of pre-calculated meals with nutritional values.
5. **Contact Us**: A page with contact information and a form to reach out for inquiries.

## Key Features

- **Search Functionality**: On the **Calculator** page, users can type in food items, and the website will fetch nutritional information about the item using an API. The search result includes detailed information such as:
  - Calories
  - Protein
  - Fat
  - Sodium
  - Potassium
  - Cholesterol
  - Carbohydrates
  - Fiber
  - Sugar
  
- **API Integration**: The application uses the [API Ninjas Nutrition API](https://api-ninjas.com/) to fetch nutritional data. The API allows searching for food items and retrieving nutritional values in JSON format.

## JavaScript Files

The **Calculator** page relies on 3 main JavaScript files:

1. **search.js**: Listens for a key press event in the search bar and triggers the search when the Enter key is pressed.
2. **ajax.js**: Handles the API request and processes the data to display it in a table format on the page.
3. **index.js**: Calls the functions from the other files to fetch and display the data.

### The JavaScript Flow:
- `search.js` captures the user’s query and sends it to the `ajax.js` file.
- `ajax.js` fetches the data from the API and populates the nutritional information into the table on the **Calculator** page.

## Current Status

The search functionality is dependent on the API key provided for the API Ninjas service. However, the API key is no longer active, so the search function is currently non-functional.
