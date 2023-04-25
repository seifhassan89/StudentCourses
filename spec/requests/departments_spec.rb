require 'swagger_helper'

RSpec.describe 'departments', type: :request do

  # Path: \departments
  path '/departments' do
    # GET ALL METHOD
    get('list departments') do
      # Gather all the tags
      tags 'Departments'
      produces 'application/json'
      # Response 200
      response(200, 'successful') do
        schema type: :array,
        items: {
        type: :object,
        properties: {
        id: { type: :integer },
        name: { type: :string },
        },
        required: ['id', 'name'],
        }
        let!(:department1) { Department.create(name: 'Department 1') }
        let!(:department2) { Department.create(name: 'Department 2') }
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
    post('create department') do
      # Gather all the tags
      tags 'Departments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :department, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Department 3' }
        },
        required: ['name']
      }
      # Response 201
      response '201', 'Department created successfully' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
          },
          required: ['name']

        let(:department) { { id: 0, name: 'Department 3' } }
        run_test!
      end

      # Response 422
      response '422', 'Invalid request parameters' do
        schema type: :object,
          properties: {
            errors: { type: :array, items: { type: :string } }
          },
          required: ['errors']

        let(:department) { { id: '', name: '' } }
        run_test!
      end

      # Response 200
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
        name: { type: :string, example: 'Hr ' }
        }
        }
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

  # Path: \departments\{id}
  path '/departments/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    # GET METHOD
    get('show department') do
      # Gather all the tags
      tags 'Departments'
      produces 'application/json'

      # Response 404
      response '404', 'Department not found' do
        schema type: :object,
          properties: {
            message: { type: :string },
          },
          required: ['message']

        let(:id) { -1 } # An ID that does not exist
        run_test!
      end

      # Response 200
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
          },
          required: ['id', 'name']

        let(:department) { Department.create(name: 'Department 1') }
        let(:id) { department.id }
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

    # PUT METHOD
    patch('update department') do
      # Gather all the tags
      tags 'Departments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'ID of the Depatment'
      let(:id) { '1' }
      parameter name: :deparmant, in: :body, schema: {
        type: :object,
        properties: {
        name: { type: :string, example: 'New deparmant' },
        },
        required: ['name'],
      }

      # Response 200
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :post, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string, example: 'Hr ' }
          }
        }
        run_test!
      end

      # Response 404
      response '404', 'Not Found' do
        schema type: :object,
          properties: {
            message: { type: :string },
          },
          required: ['message']

        let(:id) { -1 } # An ID that does not exist
        let(:name) { 'New name' }
        run_test!
      end

      # Response 422
      response '422', 'Unprocessable Entity' do
        schema type: :object,
          properties: {
            errors: { type: :array, items: { type: :string } },
          },
          required: ['errors']

        let(:deparmant) { Department.create(name: 'New Department') }
        let(:id) { deparmant.id }
        let(:name) { '' } # An empty name
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
    delete('delete department') do
      # Gather all the tags
      tags 'Departments'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      # Response 204
      response '404', 'Not Found' do
        schema type: :object,
        properties: {
        message: { type: :string },
        },
        required: ['message']

        let(:id) { -1 } # An ID that does not exist
        run_test!
      end

      # Response 200
      response(200, 'successful') do
        schema type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
        },
          required: ['id', 'name']
          let(:deparmant) { Department.create(name: 'New Department') }
          let(:id) { deparmant.id }
          let(:name) { 'New name' }
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
