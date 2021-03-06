# == Schema Information
# Schema version: 20090424001630
#
# Table name: answers
#
#  id            :integer         not null, primary key
#  body          :text
#  user_id       :integer
#  question_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#  votes_average :integer         default(0)
#  selected      :boolean
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Answer do
  before(:each) do
    @valid_attributes = {
      :body => "value for body",
      :user => Factory(:user),
      :question => Factory(:question)
    }
  end

  describe "associations" do
    it "should belong to user" do
      Answer.should belong_to(:user)
    end
    it "should belong to question" do
      Answer.should belong_to(:question)
    end
    it "should have many comments" do
      Answer.should have_many(:comments)
    end
  end

  describe "validations" do
    it "should create a new instance given valid attributes" do
      @answer = Answer.new(@valid_attributes)
      @answer.should be_valid
    end
    
    it "should require user" do
      @answer = Answer.new(@valid_attributes.merge(:user => nil))
      @answer.should_not be_valid
    end
    
    it "should require question" do
      @answer = Answer.new(@valid_attributes.merge(:question => nil))
      @answer.should_not be_valid
    end
    
    it "should require body" do
      @answer = Answer.new(@valid_attributes.merge(:body => nil))
      @answer.should_not be_valid
    end
    
  end
  
  describe "Instance Methods" do
    describe ".select!" do
      before :each do
        @last_selected_answer = Answer.create!(@valid_attributes)
        @last_selected_answer.select!
        @last_selected_answer.reload.selected.should == true 
        @new_selected_answer = Answer.create!(@valid_attributes)
        @new_selected_answer.select!
      end
    
      it "should turn the last answer selected to false" do
        @last_selected_answer.reload.selected.should == false
      end
      it "should turn the new answer selected to true" do
        @new_selected_answer.reload.selected.should == true
      end
      it "should the question flagged as answered" do
        @new_selected_answer.question.answered.should == true
      end
    end
  end
  
  
end
