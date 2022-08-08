
## Project Overview

This project is based on iOS application. Coding language is Swift, for the UI framework UIKit is being used.
Project is based on an API which provides  basic info about cities, counties, regions, and countries throughout the world.
Project is using ten elements from the API and creating a tableView with them for the user. User can access country details and can save the desired country.
## API Overview
In this section, I'm going to clarify the mentality of the GeoDB API.
This project uses two endpoints from the API;
- Countries 
```
Collects general data of the countries, which includes;
- code
- wikiDataId
- name
- currencyCodes
```
- CountryDetail
```
Collects specific data of the country, which includes;
- capital
- code
- name
- flagImageUri
- callingCode
- currencyCodes
- numRegions
- wikiDataId
```

From the country endpoint everything except "currencyCodes" is being used. From the country detail endpoint
"code", "name", "flagImageUri", "wikiDataId" is being used.
#### Example Data from CountryDetail
![Uygulama Ekran Görüntüsü](https://i.hizliresim.com/kari7bc.jpg)
#### Example Data from Countries
![Uygulama Ekran Görüntüsü](https://i.hizliresim.com/2e6oxl3.jpg)








## Architecture Overview

MVVM design pattern is being used on the application.

![Uygulama Ekran Görüntüsü](https://i.hizliresim.com/q13nz3h.gif)


## Dependencies

- https://github.com/CocoaLumberjack/CocoaLumberjack
- https://github.com/SVGKit/SVGKit.git
- https://github.com/SDWebImage/SDWebImage
