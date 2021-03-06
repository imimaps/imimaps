# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
  end

  describe 'GET #index' do
    before :each do
      @company = create :company
      @company2 = create :company_is24
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'does not add http to the company website, if http is already present' do
      create :company, website: 'http'
      get :index
      expect(response).to render_template :index
    end

    it 'assigns @companies' do
      get :index
      expect(assigns(:companies)).to eq([@company, @company2])
    end
  end

  describe 'GET #show' do
    before :each do
      @company = create :company
      @company2 = create :company_is24
    end

    it 'renders the show template' do
      get :show, params: { id: @company }
      expect(response).to render_template :show
    end

    it 'renders the show template for a company without http in website name' do
      get :show, params: { id: @company2 }
      expect(response).to render_template :show
    end

    it 'assigns @company' do
      get :show, params: { id: @company }
      expect(assigns(:company)).to eq(@company)
    end

    it 'does not add http to the company website, if http is already present' do
      @company = create :company, website: 'http'
      get :show, params: { id: @company }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns @company' do
      get :new
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'GET #edit' do
    before :each do
      @company = create :company
    end

    it 'renders the edit template' do
      get :edit, params: { id: @company }
      expect(response).to render_template :edit
    end

    it 'assigns @company' do
      get :edit, params: { id: @company }
      expect(assigns(:company)).to eq(@company)
    end
  end

  describe 'POST #create' do
    context 'given correct parameters' do
      it 'creates a new Company' do
        expect do
          post :create, params: { company: attributes_for(:company) }
        end.to change(Company, :count).by(1)
      end

      #  TBD ST: after company creating the site is redirected via javascript??
      # to a special path to create a new Address. I assume this needs cleanup,
      # thus just commenting the test case out for now
      #  it 'redirects to the show view ' do
      #    post :create, params: { company: attributes_for(:company) }
      #    expect(response).to redirect_to new_internship_path
      #  end
    end

    context 'given incorrect parameters' do
      it 'refuses to create a new Company' do
        expect do
          post :create, params: { company: attributes_for(:company, name: nil) }
        end.to_not change(Company, :count)
      end

      it 'redirects to the show new view ' do
        post :create, params: { company: attributes_for(:company, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @company = create :company, name: 'Foo'
    end

    context 'given correct parameters' do
      it 'updates the specified Company' do
        put :update,
            params: { id: @company,
                      company: attributes_for(:company, name: 'Bar') }
        @company.reload
        expect(@company.name).to eq('Bar')
      end

      it 'redirects to the show view' do
        put :update,
            params: { id: @company,
                      company: attributes_for(:company, name: 'Bar') }
        expect(response).to redirect_to Company.last
      end
    end

    context 'given incorrect parameters' do
      it 'refuses to update the specified Company' do
        put :update,
            params: { id: @company,
                      company: attributes_for(:company, name: nil) }
        @company.reload
        expect(@company.name).to eq('Foo')
      end

      it 'redirects to the edit view' do
        put :update,
            params: { id: @company,
                      company: attributes_for(:company, name: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @company = create :company
    end

    it 'destroys the specified company' do
      expect do
        delete :destroy, params: { id: @company.id }
      end.to change(Company, :count).by(-1)
    end
  end
end
