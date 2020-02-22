# swapi
A client iOS app for Star Wars api 🚀

### Details

I used MVVM design pattern to tackle this project paired with observer design pattern to reflect any changes that should apply asynchronously.
I'm talking here about the ability to load different film detail concurrently or get the list of all characters.

I used a protocol oriented programming to limit dependencies between elements which makes the code more testable and maintanable. This is also to avoid exposing too much logic to the view.
However, since the application is fairly small, I didn't want to introduce more complexity and kept it simpler for navigation for instance.

I aimed to keep function simple with one main purpose to avoid any unecessary complexity that would come in future improvements. 
That's why I've chosen to generate the detail design dynamically rather than recreating each label separately. 

Finally the design is very sober since the api doesn't include much more assets to improve it. I believe the challenge wasn't on the design itself. 

Any suggestion or feedback are welcome, thanks!
