 require "rails_helper"
 require 'spec_helper'
    RSpec.describe MicropostsController do
      render_views
        describe "access control" do
            it "should deny access to 'create'" do
               post :create
               response.should redirect_to(login_path)
            end
            it "should deny access to 'destroy'" do
               delete :destroy, :id => 1
               response.should redirect_to(login_path)
            end
        end
        describe "POST 'create'" do
             before(:each) do
             @user = test_log_in(FactoryGirl.create(:user))
             end
        describe "failure" do
             before(:each) do
             @attr = { :content => "" }
             end
            it "should not create a micropost" do
                 lambda do
                    post :create, :micropost => @attr
                    should_not change(Micropost, :count)
                end
            end
            it "should re-render the home page" do
                 post :create, :micropost => @attr
                 response.should render_template :home
            end
        end
        describe "success" do
             before(:each) do
             @attr = { :content => "hello everyone!" }
             end
            it "should create a micropost" do
               lambda do
               post :create, :micropost => @attr
               should change(Micropost, :count).by(1)
               end
            end
            it "should redirect to the root path" do
               post :create, :micropost => @attr
               response.should redirect_to(root_path)
            end
            it "should have a flash success message" do
               post :create, :micropost => @attr
               end
            end
        end
        describe "DELETE 'destroy'" do
             describe "for an unauthorized user" do
                before(:each) do
                @user = FactoryGirl.create(:user)
                wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
                @micropost = FactoryGirl.create(:micropost, :user => @user)
                test_log_in(wrong_user)
                end
             it "should deny access" do
               delete :destroy, :id => @micropost
               response.should redirect_to(root_path)
             end
            end
            describe "for an authorized user" do
                  before(:each) do
                  @user = test_log_in(FactoryGirl.create(:user))
                  @micropost = FactoryGirl.create(:micropost, :user => @user)
                  end
                it "should destroy the micropost" do
                     lambda do
                      delete :destroy, :id => @micropost
                      response.should redirect_to(root_path)
                      should change(Micropost, :count).by(-1)
                      end
                end
            end
        end
    end
