# Charlottesville Community Volunteer Log Application

Volunteer is a CRUD, Model-View-Controller web application using the Sinatra framework. This application  allows a user the ability to create an account, add volunteer entries to their log and edit volunteer entries. A volunteer has many entries and a log and it's entries belongs to a user; entries and logs cannot be edited by other users. 

## Installation

You can install this app by running in your terminal git clone git@github.com:smartinsci/volunteer.git

## Usage

After cloning, change directory to Volunteer $ cd volunteer, and run the following:

    $ bundle install
    $ rake db:migrate
    $ shotgun

## Contributing

Bug reports and pull requests are welcome on GitHub at `https://github.com/'diligent-markup-7911'/volunteer`. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GlobalFoodFestivals project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SMartinSci/volunteer/blob/master/CODE_OF_CONDUCT.md).

## Credits

Bootstrap references were obtained from [here](https://getbootstrap.com/). Project structure developed with Corneal gem.