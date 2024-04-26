# Energise.pro (Test application)

## What was do in this app

Test task from the company https://energise.pro/

**Basic requirements:**

Swift
MVC architecture

**Requirements:** Design in any format (any, we count on your creativity)

*Home screen*

- In the center, put a round button with the "Play" icon, which should pulsate animatedly
- above the button we place a timer in the form (00:00:00)
- When pressing the "Play" button, rename the button to "Pause" with an icon, remove the animation, add a pulsation animation to the timer and start the timer. Stop the timer and press Pause to return the timer to its initial state

*Second screen*

- Using the API of the service https://ip-api.com/ we get all the information by IP
- Insert a map at the beginning of the screen, after receiving the location from the service, display it on the map. (view height +- 150-200)
- Below the map, we display all information from the service in an arbitrary form, with animation
- At the bottom, we add the "Reload" button, when pressed, a request for the service is sent and we update the data

*Third Screen*

- Create a table or collection with active buttons
- Must contain: Rate App - call the apple method that causes the star rating alert, Share App - call the method to share content, Contact us - create a method that natively opens the browser and goes to the link of this TK

## What was used to make this app

* The Swift Programming Language
* MVC
* Storyboard
* XIB
* UserDefault
* Alamofire (networking)
* Work with UITableView, UITableViewController set their data sources and delegates
* Timer
* Pulse animation
* UIActivityViewController
* SKStoreReviewController
* Integrate third party libraries using Pods

## Example what the application do

![Test application example of work.](Documentation/energise_screenrecord.gif)
