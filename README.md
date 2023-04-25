# Student Courses Management Web API
This is a simple Student Course Registration WebApi that allows students to view courses and register for them, while instructors can manage student registrations
and view student data. The project is built using Ruby On Rails, ActiveRecord and mysql2.

## Features
- CRUD operations for students and their gender.
- CRUD operations for Courses and their Department.

## Technologies Used
- Ruby
- Ruby on rails
- mysql2 database
- Swagger

## Getting Started
To get started with this project, follow these steps:

## Installing
1. Clone the repository to your local machine.
```
git clone https://github.com/seifhassan89/StudentCourses
```
2. Install Ruby and Ruby on Rails if you haven't already
```
gem install rails -v 5.0.1
```
3. Run bundle install to install all required gems.
```
bundle install
```


## Database Connection
1.to create the database run:
```
db:create
```
2.to run the database migrations run:
```
db:migrate
```


## Run the application
1. Here is command to run your application:
```
rails s
```
You should now be able to access the application at http://localhost:3000.
As you should now be able to access the Swagger Documentation at http://localhost:3000/api-docs/index.html Or http://localhost:3000/Api/#.

## Usage
The API endpoints can be tested using a tool such as Postman. The following endpoints are available:

![image](https://user-images.githubusercontent.com/64795421/234276790-65d1ae1c-25ec-4ffe-a44e-402466f371ff.png)
![image](https://user-images.githubusercontent.com/64795421/234276880-568fb89d-1ae1-421a-84d0-20f1452d97db.png)
![image](https://user-images.githubusercontent.com/64795421/234276931-bfa99ebe-4129-40d9-893d-9c0898ecd53f.png)
![image](https://user-images.githubusercontent.com/64795421/234277008-07f115c2-e2de-4fc1-906f-00f175342d3e.png)

## Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new feature branch.
3. Make your changes.
4. Create a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
