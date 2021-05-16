require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  describe "get customers_path" do
    #passes
    it "renders the index view" do
      FactoryBot.create_list(:customer, 10)
      get customers_path
      expect(response).to render_template(:index)
    end
  end
  describe "get customer_path" do
    #passes
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get customer_path(id: customer.id)
      expect(response).to render_template(:show)
    end
    #passes - changed controller's show method
    it "redirects to the index path if the customer id is invalid" do
      FactoryBot.create_list(:customer, 10)
      get customer_path(id: 5000)
      expect(response).to redirect_to customers_path
    end
  end
  describe "get new customer path" do
    #passes
    it "renders the :new template" do
      get new_customer_path
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_customer_path" do
    #passes
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post customers_path with invalid data" do
    #passes
    it "does not save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect {
        post customers_path, params: {customer: customer_attributes}
      }.to_not change(Customer, :count)
      expect(response).to render_template(:new)
    end
  end
  describe "put customer_path with valid data" do
    #not passes yet
    it "updates an entry and redirects to the show path for the customer" do
      customer = FactoryBot.create(:customer)
      customer.first_name = 'Test'
      expect {
        put customer_path(id: customer.id), params: {customer: customer[params]}
      }.to change(customer, :first_name).to('Test')
      expect(response).to redirect_to customers_path(id: customer.id)
    end
  end
  describe "put customer_path with invalid data" do
    #not passes yet
    it "does not update the customer record or redirect" do
      customer1 = FactoryBot.build(:customer)
      customer2 = customer1
      customer2.first_name = ''
      expect {
        put customer_path(id: customer1.id), params: {customer: customer2}
      }.to_not change(customer1, :first_name)
      expect(response).to render_template(:edit)
    end
  end
  describe "delete a customer record" do
    it "deletes a customer record and redirects to customers_path" do
      #passes
      FactoryBot.create_list(:customer, 10)
      customer = FactoryBot.create(:customer)
      expect {
        delete customer_path(id: customer.id)
      }.to change(Customer, :count).by(-1)
      expect(response).to redirect_to customers_path
    end
  end
end
