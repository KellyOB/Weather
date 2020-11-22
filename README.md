# Weather

Week 8 Exercise for Devslopes Academy

A weather app that gets the weather forecast for the user's current location.

# Requirements
* Your app will grab your current location and automatically pull up today's weather
* You will show the appropriate icon to match the weather
* Show the title of the current weather, such as "Cloudy"
* Show today's date
* Have a button/tab that says "Today". If selected it shows 5 hours worth of weather (see screenshot)
* Have a button/tab that says "Weekly". If selected it shows 5 days worth of weather (see screenshot)

# Screenshots

<img src = "https://user-images.githubusercontent.com/32715761/99889350-14c95a00-2c09-11eb-9758-36121e3004b7.png" width="200" hspace="10" /> <img src = "https://user-images.githubusercontent.com/32715761/99889414-b3ee5180-2c09-11eb-9fdd-b0c0e056ea49.png" width="200" hspace="30" />

# Features
* Weather API - free weather API from [OpenWeatherMap](https://openweathermap.org/api)
* MVC design pattern
* Core Location 
* Multi-threading


####  APIService.swift file hidden by .gitignore file
```swift
class APIService
{
    static let shared = APIService()
    let apiKey = "YOUR API KEY HERE"
}
```
