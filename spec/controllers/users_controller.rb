require "rails_helper"
require 'spec_helper'

RSpec.describe UsersController do 
	describe "GET #new" do 
		it "should render new template" do 
			get :new
			expect(response).to render_template("users/new")
		end

		it "assigns a new User to @user" do 
			get :new
			expect(assigns(:user)).to be_instance_of(User)
		end
	end

	# describe "GET #index" do
	# 	it "assigns a varaible @users" do 
 #         get :index
 #         # users = FactoryGirl.create :user
 #         # expect(User.all.count).to eq 30
 #        end
 #    end


    describe 'GET #index' do 
        render_views
        describe "for non-logged-in users" do
            it "should deny access" do
                get :index
                response.should redirect_to(login_path)
               
            end
        end
        describe "for logged-in-users" do

            before(:each) do
                @user = test_log_in(FactoryGirl.create :user)
                second = FactoryGirl.create :user, :email => "another@example.com"
                third  = FactoryGirl.create :user, :email => "another@example.net"

                @users = [@user, second, third]

                30.times do
                     @users << FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
                end
            end
            it "should be successful" do
                get :index
                expect(response).to render_template :index
            end
        end
    end
  
    describe 'GET #show' do    
        context "assigns the requested user to @user " do
             before(:each) do
              @user=FactoryGirl.create :user
              get :show, id: @user.id
              assigns(:user).should == @user
            end   
        context "assigns the requested micropost to @micropost " do
             before(:each) do
              @micropost=FactoryGirl.create :micropost
              get :show, id: @user.id
              assigns(:micropost).should == @micropost
            end
        end
        context "assigns the requested comment to @comment " do
             before(:each) do
              @comment=FactoryGirl.create :comment
              get :show, id: @user.id
              assigns(:comment).should == @comment
            end
        end

             it "renders the :show template" do
               get :show, id: @user.id
               expect(response).to render_template :show
           
             end 
        end     
    end
    
    # describe 'GET #show' do    
    #     context "assigns the requested user to @user and micropost to @micropost and comment to @comment" do
    #   	   before(:each) do
    #        @user=FactoryGirl.create :user
    #        @micropost=FactoryGirl.create :micropost
    #        @comment=FactoryGirl.create :comment
    #        assigns(:user).should == @user
    #        assigns(:micropost).should == @micropost
    #        assigns(:comment).should == @comment
    #        end

    #     it "renders the :show template" do
    #        get :show, id: @user.id
    #        expect(response).to render_template :show
    #        end
    #     end  
    # end

    
    describe "#edit" do
        render_views
    	context "assigns the requested User to @user" do
    	    before(:each) do
            @user=test_log_in(FactoryGirl.create :user)
            end
        it "user should be able to edit his profile" do
           
            get :edit, id: @user
            expect(response).to render_template :edit
            end
        end
    end
    describe "PUT 'update'" do
           before(:each) do
           @user=test_log_in(FactoryGirl.create :user)
           end


      describe "failure" do

          before(:each) do
          @attr = { :email => "", :name => "", :password => "", :password_confirmation => "" }
          end

        it "should render the 'edit' page" do
           put :update, :id => @user, :user => @attr
           response.should render_template('edit')
        end

    # it "should have the right title" do
    #   put :update, :id => @user, :user => @attr
    #   response.should have_selector("title", :content => "Edit user")
    # end
      end

      describe "success" do

          before(:each) do
          @attr = { :name => "New Name", :email => "user@example.org", :password => "barbaz", :password_confirmation => "barbaz" }
          end

        it "should change the user's attributes" do
           put :update, :id => @user, :user => @attr
           # @user.reload
           # @user.name.should  == @attr[:name]
           # @user.email.should == @attr[:email]
        end

        it "should redirect to the user show page" do
          put :update, :id => @user, :user => @attr
          response.should redirect_to(user_path(@user))
        end

        # it "should have a flash message" do
        #    put :update, :id => @user, :user => @attr
        #    flash[:success].should =~ /updated/
        # end
      end
    end
    describe 'DELETE destroy' do
        	before(:each) do
            @user = FactoryGirl.create :user
            end
        describe "as a non-admin user" do
        it "should protect the page" do
           test_log_in(@user)
           delete :destroy, :id => @user
           response.should redirect_to(root_path)
           end
        end
        describe "as an admin user" do

            before(:each) do
            admin = FactoryGirl.create(:user, :email => "admin@example.com", :admin => true)
            test_log_in(admin)
            end
            it "should destroy the user" do
                 lambda do
                    delete :destroy, :id => @user
                    should change(User, :count).by(-1)
                 end
            end

            it "should redirect to the users page" do
                delete :destroy, :id => @user
                response.should redirect_to(users_path)
                end
            end
         end

    #         expect{
    #           delete :destroy, {id: @user.id}        
    #          }.to change(User,:count).by(-1)
    #         end
    #     end

    #     context "redirects to Users#index" do
    #     	before(:each) do
    #         @user = FactoryGirl.create :user
    #         delete :destroy, {id: @user.id}
    #         response.should redirect_to users_url
    #         end
    #     end
    # end


  # describe "#create" do
  #            before(:each) do
  #            @user = User.create(name: "name",email: "email",password: "password",password_confirmation:"password_confirmation")
  #            end
  #       it "creates a successful users" do
             
  #            post :create,{user: @user}
  #            @user.should be_an_instance_of User
  #       end
  #   describe "failure" do
  #          before(:each) do
  #            @user_invalid = User.create(name: "",email: "",password: "",password_confirmation:"")
  #          end  
  #       it "create a unsuccessful user" do
  #           post :create,{user: @user_invalid}
  #           response.should render_template('users/new')
  #       end     
  #   end
  # end

  describe "POST 'create'" do
        before(:each) do
         @user = FactoryGirl.create(:user)
         end
    describe "failure" do
        before(:each) do
        @attr = { :name => "", :email => "", :password => "",
        :password_confirmation => "" }
        end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      it "should not create a user" do
        lambda do
           post :create, :user => @attr
           should_not change(User, :count)
        end
      end
    end
    describe "success" do
          before(:each) do
          @attr = { :name => "New User", :email => "user@example.com",
          :password => "foobar", :password_confirmation => "foobar" }
          end
      it "should create a user" do
          lambda do
            post :create, :user => @attr
            should change(User, :count).by(1)
            end
      end
      it "should redirect to the user show page" do
        debugger
         post :create, :user => @attr, :id =>@user.id
         response.should redirect_to(@user)
      end
      it "should log the user in" do
          post :create, :user => @attr 
          controller.should be_logged_in
      end
    end
  end
  # describe "follow pages" do
  #     describe "when not signed in" do
  #       it "should protect 'following'" do
  #          get :following, :id => 1
  #          response.should redirect_to(login_path)
  #       end
  #       it "should protect 'followers'" do
  #          get :followers, :id => 1
  #          response.should redirect_to(login_path)
  #       end
  #     end
  #     describe "when logged in" do
  #         before(:each) do
  #           @user = test_log_in(FactoryGirl.create(:user))
  #           @other_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
  #           @user.follow!(@other_user)
  #         end
  #       it "should show user following" do
  #          get :following, :id => @user
  #          response.should have_selector('a', :href => user_path(@other_user),
  #          :content => @other_user.name)
  #       end
  #       it "should show user followers" do
  #           get :followers, :id => @other_user
  #           response.should have_selector('a', :href => user_path(@user),
  #           :content => @user.name)
  #       end
  #     end
  # end
    # describe '#destroy' do

    #    context 'when resource is found' do
    #     it 'shows the resource'
    #    end

    #    context 'when resource is not found' do
    #     it 'responds with 404'
    #    end
    # end   
	# describe "GET 'new'" do
 #         it "assigns a new User to @user" do
 #           User.should_receive(:new).and_return(@user)
 #           get :new
 #           assigns(:user).should == @user
 #        end
 #         it "renders the :new template" do 
	#  		get :new
	#  		expect(response).to render_template("users/new")
	# 	end
 #    end
    
end