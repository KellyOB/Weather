# Weather


A weather app that gets the weather forecast for the user's current location.

# Requirements
* Your app will grab your current location and automatically pull up today's weather
* You will show the appropriate icon to match the weather
* Show the title of the current weather, such as "Cloudy"
* Show today's date
* Have a button/tab that says "Today". If selected it shows 5 hours worth of weather (see screenshot)
* Have a button/tab that says "Weekly". If selected it shows 5 days worth of weather (see screenshot)

#Screenshots


Demo(Images, Video links, Live Demo links)

# Technologies Used
Uses weather API
MVC design pattern
CLLocationManager to pull in location 

DispatchQueue to get the weather data
Special Gotchas of your projects (Problems you faced, unique elements of your project)


* APIService file hidden by .gitignore file
class APIService
{
    static let shared = APIService()
    let apiKey = "YOUR API KEY HERE"
}
