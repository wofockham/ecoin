require 'spec_helper'

describe MerchantsController do
    describe 'GET for index' do
        before do
        get :index
      end

      it "should respond with a status 200" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

       it "should render the index template" do
        expect(response).to render_template("index")
      end

    end

 describe 'Sign Up' do
    before do
      post :create, { :merchant => {:name  => "Lego House", :email => 'lego@gmail.com' ,:password => "a", :password_confirmation => "a"}}
    end

    it "should create a new merchant" do
      expect(assigns(:merchant).name).to eq("Lego House")
      (:merchant).should_not be_nil
    end
  end
end

