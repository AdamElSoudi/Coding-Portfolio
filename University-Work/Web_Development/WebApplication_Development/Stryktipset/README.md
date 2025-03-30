# Fotbadskollen.se Stryktips Viewer

## Project Overview

This project is designed to demonstrate competency in constructing dynamic web applications with JavaScript and integrating them with external systems. The application fetches and displays football match data (Stryktips) from a fixed API for Fotbadskollen.se, a site that desires to offer its users the ability to view football betting tips.

### Background

Fotbadskollen.se requested a JavaScript-based solution to integrate Stryktips data into their website. The site's design team has already developed the necessary HTML and CSS. The primary task was to implement JavaScript to fetch and display the Stryktips data correctly.

## Features

- **Dynamic Content Generation**: Football matches are dynamically generated and displayed on the page using JavaScript. Each match entry shows the teams that played and indicates the winner with a checkmark (1 X 2).
- **Interactive Links**: Users can click on a football team's name to navigate to that team's official website.
- **Data Fetching**: Stryktips data is fetched from the [provided API](https://stryk.herokuapp.com/strycket2022) using AJAX techniques to ensure that the API's format changes during the course do not affect the application.

## Technologies Used

- **JavaScript**: The entire functionality of fetching and displaying Stryktips data is handled through JavaScript without the use of external libraries.
- **HTML/CSS**: Provided by the design team of Fotbadskollen.se and unmodified except for the addition of script tags to load JavaScript code.

## Development

The solution involves:
- **Modular JavaScript**: The project is structured into at least two ES6 modules, emphasizing the use of `import/export`
