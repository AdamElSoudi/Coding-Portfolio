# Linux Assignment 9 - Debian Package Management & Man Page Creation  

## Overview  
This project was part of my Linux course, where I explored Debian's package management system, specifically working with `dpkg` and `APT`. The primary objective was to package a standalone version of `electrotest`, an application I originally developed in assignment 6 for the course Linux Development Environment 1. Additionally, I created a simple man page for the application.  

## Project Scope  
- Converted `electrotest` into a standalone C program (`electrotest-standalone.c`) that does not rely on dynamically linked libraries.  
- Packaged the program as a `.deb` package using `debmake` and `debuild`.  
- Ensured proper installation of the package in the appropriate system directories.  
- Addressed package quality checks using `lintian`, resolving all but specific non-critical warnings.  
- Verified package integrity using `dpkg-deb`.  

## About Electrotest  
The `electrotest` application is designed to perform electrical calculations, including:  
- Computing total resistance for series and parallel resistor circuits.  
- Calculating power dissipation using voltage and resistance or voltage and current.  
- Determining the closest E12-series replacement resistors.  

Originally, the program was built using multiple dynamic libraries. For this lab, I restructured it into a single standalone C file to make packaging simpler.

## Running the Program  
Since I worked on macOS, I used [UTM](https://mac.getutm.app/) as my virtual machine to run Linux. To execute the `electrotest` program:  

1. Open a terminal and navigate to the directory where `electrotest` is located.  
2. Run the program with the following command:  

   ```bash
   ./electrotest
