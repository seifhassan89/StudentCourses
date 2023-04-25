require 'swagger_helper'

RSpec.describe 'genders', type: :request do

  # Path: \genders
  path '/genders' do
    # GET ALL METHOD
    get('list genders') do
      # Gather all the tags
      tags 'Genders'
      produces 'application/json'
      # Response 200
      response(200, 'successful') do
      schema type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string, enum: ['Male', 'Female', 'Not to say', 'New name'] },
                },
                required: ['id', 'name'],
              }

        let!(:male) { Gender.create(name: 'Male') }
        let!(:female) { Gender.create(name: 'Female') }
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
    post('create gender') do
      # Gather all the tags
      tags 'Genders'
      consumes 'application/json'
      produces 'application/json'
      # Response 200
      response(200, 'successful') do
        parameter name: :gender, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Not to say' }
        },
          required: [ 'name' ]
        }
        run_test!
      end
      # Response 201
      response '201', 'Student created successfully' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string, enum: ['Male', 'Female'] },
          },
          required: ['name' ]

          let(:gender) { { id:0, name: 'Male' } }
          run_test!
      end
      # Response 422
      response '422', 'Invalid request parameters' do
        schema type: :object,
          properties: {
            errors: { type: :array, items: { type: :string } }
          },
          required: [ 'errors' ]

        let(:gender) { { id: '', gender: '' } }
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

  # Path: \genders\{id}
  path '/genders/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    # GET METHOD
    get('show gender') do
      tags 'Genders'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the gender'
      # Response 404
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
        name: { type: :string, enum: ['Male', 'Female'] },
        }
        let(:gender) { { id:0, name: 'Male' } }

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

    # PATCH METHOD
    patch('update gender') do
      # Gather all the tags
        tags 'Genders'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, description: 'ID of the gender'
        parameter name: :gender, in: :body, schema: {
          type: :object,
          properties: {
          name: { type: :string, example: 'New name' },
          },
          required: ['name'],
        }
        # Response 200
        response(200, 'successful') do
          schema type: :object,
          properties: {
          id: { type: :integer },
          name: { type: :string, enum: ['Male', 'Female', 'Not to say', 'New name'] },
          },
          required: ['id', 'name']
          let(:gender) { Gender.create(name: 'Male') }
          let(:id) { gender.id }
          let(:name) { 'New name' }
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

          let(:gender) { Gender.create(name: 'Male') }
          let(:id) { gender.id }
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
    delete('delete gender') do
      tags 'Genders'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the gender'

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
        name: { type: :string, enum: ['Male', 'Female', 'Not to say', 'New name'] },
        },
        required: ['id', 'name']

        let(:gender) { Gender.create(name: 'Male') }
        let(:id) { gender.id }
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
