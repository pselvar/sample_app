require 'spec_helper'

describe User do
  before(:each) do
      @attr = {:name=>'test',:email=>'test@test.com',:password => 'test_password',:password_confirmation => 'test_password'}
  end

  it "should create new user" do
        if @attr.nil?
            print "Attr is nil"
        else
            print "Attr is not nil"
        end
        u = User.create!(@attr)
  end

  it "should not create an User if the name is blank" do
    noname_user= User.new(@attr.merge(:name=>''))
    noname_user.should_not be_valid
  end

  it "should not create a name withh length greater than 50" do
      l_name = "a"*56
      l_name_user =  User.new(@attr.merge(:name=>l_name))
      l_name_user.should_not be_valid
  end

  it "should not create a email which is blank" do
     e = User.new(@attr.merge(:email=>''))
     e.should_not be_valid
  end

  it "should not create an email which is not of proper format" do
     e = User.new(@attr.merge(:email=>'ad@as@@a.com'))
     e.should_not be_valid
  end

  it "should not create two users with same email address." do
    User.create!(@attr)
    e = User.new(@attr.merge(:email=>@attr[:email].upcase))
    print e[:email]
    
    e.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
        p = User.new(@attr.merge(:password=>'',:password_confirmation=>''))
        p.should_not  be_valid
    end
    it "should require matching passwd confirmation" do
        p = User.new(@attr.merge(:password_confirmation=>'changes'))
        p.should_not be_valid
    end
    it "should not be less than 5 characters" do
        short_password ="t"*5
        p = User.new(@attr.merge(:password=>short_password))
        p.should_not be_valid
    end
    it "should not be greater
    than 40 characters" do
        long_password = "t"*45
        p = User.new(@attr.merge(:password => long_password))
        p.should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
        @user = User.create!(@attr)
    end
    it "should have encrypt_password attribute" do
        @user.should respond_to(:encrypted_password)
    end
    
    it "encrypted_password should not be blank" do
        @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
        it "should be true if passwords match" do
            @user.has_password?(@attr[:password]).should be_true
        end

        it "should be false if the passwords dont match" do
            @user.has_password?("invalid").should be_false
        end
    end

    describe "authenticate method" do
        it "should return nil on password/email mismatch" do
            w_user = User.authenticate(@attr[:email],"abc")
            w_user.should be_nil
        end
        it "should return nill for email with no user" do
            w_user = User.authenticate("test@test,com",@attr[:password]) 
            w_user.should be_nil
        end
        it "should return the user on email/password match" do
            m_user = User.authenticate(@attr[:email],@attr[:password])
            m_user.should == @user
        end
    end
  end
end
