require 'swagger_helper'

RSpec.describe 'courses', type: :request do

  # Path: \courses
  path '/courses' do
    # GET ALL METHOD
    get('list courses') do
      # Gather all the tags
      tags 'Courses'
      produces 'application/json'
      # Response 200
      response(200, 'successful') do
        schema type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    name: { type: :string },
                    description: { type: :text },
                    credits: { type: :integer },
                    department_id: { type: :integer }
                  },
                  required: ['id', 'name', 'description', 'credits', 'department_id']
                }

        let!(:course1) { Course.create(name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1) }
        let!(:course2) { Course.create(name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1) }
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
    post('create course') do
      # Gather all the tags
      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Hr Fundimentals' },
          description: { type: :text, example: 'test description data' },
          credits: { type: :integer, example: 60 },
          department_id: { type: :integer, example: 1 }
        },
        required: ['name', 'description', 'credits', 'department_id']
      }

      # Response 201
      response '201', 'Course created successfully' do
        schema type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  description: { type: :text },
                  credits: { type: :integer },
                  department_id: { type: :integer }
                },
                required: ['name', 'description', 'credits', 'department_id']

        let(:course) { { id: 0, name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1 } }
        run_test!
      end

      # Response 422
      response '422', 'invalid request' do
        let(:course) { { name: 'foo' } }
        run_test!
      end

      # Response 200
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string, example: 'Hr Fundimentals' },
            description: { type: :text, example: 'test description data' },
            credits: { type: :integer, example: 60 },
            department_id: { type: :integer, example: 1 }
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

    end
  end

  # Path: \courses\{id}
  path '/courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    # GET METHOD
    get('show course') do
      # Gather all the tags
      tags 'Courses'
      produces 'application/json'
      # Response 200
      response(200, 'successful') do
        schema type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  description: { type: :text },
                  credits: { type: :integer },
                  department_id: { type: :integer }
                },
                required: ['id', 'name', 'description', 'credits', 'department_id']
                
        let(:id) { '123' }
        let(:course) { Course.create(name: 'course 1', description: "this is my description" , credits: 60 , department_id: 1 ) }

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
    patch('update course') do
      # Gather all the tags
      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the Course'
      let(:id) { '1' }
      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Hr Fundimentals' },
          description: { type: :text, example: 'test description data' },
          credits: { type: :integer, example: 60 },
          department_id: { type: :integer, example: 1 }
        },
        required: ['name', 'description', 'credits', 'department_id']
      }
      let(:course) { { name: 'Hr Fundimentals', description: 'test description data', credits: 60, department_id: 1 } }

      # Response 200
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string, example: 'Hr Fundimentals' },
            description: { type: :text, example: 'test description data' },
            credits: { type: :integer, example: 60 },
            department_id: { type: :integer, example: 1 }
          }
        }
        run_test!
      end

      # Response 404
      response(404, 'not found') do
        let(:id) { 'invalid' }
        run_test!
      end

      # Response 422
      response(422, 'invalid request') do
        let(:course) { { name: 'foo' } }
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
    delete('delete course') do
      # Gather all the tags
      tags 'Courses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the Course'
      let(:id) { '1' }

      # Response 200
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string, example: 'Hr Fundimentals' },
            description: { type: :text, example: 'test description data' },
            credits: { type: :integer, example: 60 },
            department_id: { type: :integer, example: 1 }
          }
        }
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
