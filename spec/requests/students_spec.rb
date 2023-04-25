require 'swagger_helper'

RSpec.describe 'students', type: :request do

  # Path: /students
  path '/students' do
    # GET ALL METHOD
    get('list students') do
      # Gather all the tags
      tags 'Students'
      produces 'application/json'

      # Response 200
      response(200, 'successful') do
        schema type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    first_name: { type: :string },
                    last_name: { type: :string },
                    age: { type: :integer },
                    gender_id: { type: :integer },
                    gender_name: { type: :string },
                    courses: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          name: { type: :string },
                          description: { type: :string },
                          credits: { type: :integer },
                          department_id: { type: :integer }
                        }
                      }
                    }
                  }
                }

        let!(:course1) { Course.create(name: 'Hr Fundamentals', description: 'test description data', credits: 60, department_id: 1) }
        let!(:course2) { Course.create(name: 'Hr Fundamentals', description: 'test description data', credits: 60, department_id: 1) }
        let!(:student1) { Student.create(first_name: 'firstName', last_name: 'lastName', age: 15, gender_id: 1, gender_name: 'Male', courses: [course1, course2]) }
        let!(:student2) { Student.create(first_name: 'firstName', last_name: 'lastName', age: 15, gender_id: 1, gender_name: 'Male', courses: [course1, course2]) }

        run_test!
      end

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end
    end

    # POST METHOD
    post('create student') do
      # Gather all the tags
      tags 'Students'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :student, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string, example: 'John' },
          last_name: { type: :string, example: 'Doe' },
          age: { type: :integer, example: 25 },
          gender_id: { type: :integer, example: 1 },
          course_ids: {
            type: :array,
            items: {
              type: :string,  example: '1'
            }
          }
        }
      }
      # Response 201
      response(201, 'Student created successfully') do
        schema type: :object,
                properties: {
                  id: { type: :integer },
                  first_name: { type: :string },
                  last_name: { type: :string },
                  age: { type: :integer },
                  gender_id: { type: :integer },
                  gender_name: { type: :string },
                  courses: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        name: { type: :string },
                        description: { type: :string },
                        credits: { type: :integer },
                        department_id: { type: :integer }
                      }
                    }
                  }
                },
                required: ['first_name','last_name','age','gender_id','courses']
        let(:course) { { id: 0, name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1 } }
        let!(:student1) {Student.create(first_name:"firstName",last_name:'lastName',age:15,gender_id:1,gender_name:"Male",courses:[course])}
        run_test!
      end
      # Response 422
      response 422, 'Invalid request' do
        let(:student) { { first_name: 'foo' } }
        run_test!
      end

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end
    end
  end

  # Path: \students\{id}
  path '/students/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    # GET METHOD
    get('show student') do
  # Gather all the tags
  tags 'Students'
  produces 'application/json'

  # Response 200
  response(200, 'successful') do
    schema type: :object,
            properties: {
              id: { type: :integer },
              first_name: { type: :string },
              last_name: { type: :string },
              age: { type: :integer },
              gender_id: { type: :integer },
              gender_name: { type: :string },
              courses: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    name: { type: :string },
                    description: { type: :string },
                    credits: { type: :integer },
                    department_id: { type: :integer }
                  }
                }
              }
            }
    let(:id) {'1'}
    let(:course) { Course.create(name: 'course 1', description: "this is my description" , credits: 60 , department_id: 1 ) }
    let!(:student) {Student.create(first_name:"firstName",last_name:'lastName',age:15,gender_id:1,gender_name:"Male",courses:[course])}
    run_test!
  end

  # Response 404
  response(404, 'not found') do
    let(:id) { 'invalid' }
    run_test!
  end

  after do |example|
    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end
end

    # PATCH METHOD
    patch 'update student' do
      # Gather all the tags
      tags 'Students'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :student, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string, example: 'John' },
          last_name: { type: :string, example: 'Doe' },
          age: { type: :integer, example: 25 },
          gender_id: { type: :integer, example: 1 },
          gender_name: { type: :string, example: "Male" },
          courses: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                description: { type: :string },
                credits: { type: :integer },
                department_id: { type: :integer }
              }
            }
          }
        }
      }

      # Response 200
      response(200, 'successful') do
        schema type: :object,
          properties: {
            first_name: { type: :string, example: 'John' },
            last_name: { type: :string, example: 'Doe' },
            age: { type: :integer, example: 25 },
            gender_id: { type: :integer, example: 1 },
            gender_name: { type: :string, example: "Male" },
            courses: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  description: { type: :string },
                  credits: { type: :integer },
                  department_id: { type: :integer }
                }
              }
            }
          }

        let(:id) { '1' }
        let(:course) { { id: 0, name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1 } }
        let!(:student) { Student.create(first_name:"firstName", last_name:'lastName', age:15, gender_id:1, gender_name:"Male", courses:[course]) }
        run_test!
      end

      # Response 404
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end
    end

    # DELETE METHOD
    delete('delete student') do
      # Gather all the tags
      tags 'Students'
      produces 'application/json'

      # Response 200
      response(200, 'successful') do
        schema type: :object,
                properties: {
                  id: { type: :integer },
                  first_name: { type: :string },
                  last_name: { type: :string },
                  age: { type: :integer },
                  gender_id: { type: :integer },
                  gender_name: { type: :string },
                  courses: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        name: { type: :string },
                        description: { type: :string },
                        credits: { type: :integer },
                        department_id: { type: :integer }
                      }
                    }
                  }
                },
                required: ['first_name','last_name','age','gender_id','courses']
        let(:course) { { id: 0, name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1 } }
        let!(:student1) {Student.create(first_name:"firstName",last_name:'lastName',age:15,gender_id:1,gender_name:"Male",courses:[course])}
        run_test!
      end

      # Response 404
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end
    end
  end
end
