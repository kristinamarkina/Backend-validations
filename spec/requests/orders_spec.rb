require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  #pass
  describe "get orders_path" do
    it "renders the index view" do
      order = FactoryBot.create(:order)
      get orders_path, params: {order: {product_count: 2}}
      expect(response).to render_template(:index)
    end
  end
  #pass
  describe "get order_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order)
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000)
      expect(response).to redirect_to orders_path
    end
  end
  #pass
  describe "get new_order_path" do
    it "renders the :new template" do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end

  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response).to render_template(:edit)
    end
  end

  describe "post orders_path with valid data" do
    it "saves new order and renders the index view" do
      order_attributes = FactoryBot.attributes_for(:order)
      post orders_path, params: {order: order_attributes }
      expect(response).to be_successful
    end
  end

  describe "post orders_path with invalid data" do
    it "does not save new order or redirect" do
      order = FactoryBot.create(:order)
      post orders_path, params: {order: {product_count: "ten"}}
      expect(order.product_count).to_not eq("ten")
      expect(response).to render_template(:new)
    end
  end

  describe "put order_path with invalid data" do
    it "does not update the order or redirect" do
      order = FactoryBot.create(:order)
      put order_path(id: order.id), params: {order: {product_name: nil}}
      order.reload
      expect(response).to render_template(:edit)
    end
  end

  describe "put order_path with valid data" do
    it "updates the order and renders the show view" do
      order = FactoryBot.create(:order)
      put order_path(id: order.id), params: {order: {product_name: "Pirogi"}}
      order.reload
      expect(order.product_name).to eq("Pirogi")
      expect(response).to redirect_to order_path(id: order.id)
      end
  end

  describe "delete an order record" do
    it "deletes an order record and redirects to orders_path" do
      FactoryBot.create_list(:order, 3)
      order = FactoryBot.create(:order)
      expect {
        delete order_path(id: order.id)
      }.to change(Order, :count).by(-1)
      expect(response).to redirect_to orders_path
    end
  end
end
