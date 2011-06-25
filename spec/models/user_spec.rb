require 'spec_helper'

describe User do
  before(:each) do
      @attr = {:name=>'test',:email=>'test@test.com'}
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
    
end
