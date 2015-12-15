require 'spec_helper'

RSpec.describe ServiceMonster::Client::Reminders do
  
  before do
    @client = ServiceMonster::Client.new
  end

  describe '#reminders' do

    before do
      stub_get("reminders").to_return(body: fixture('reminders_list.json'), :headers => {:content_type => "application/json; charset=utf-8", authorization: 'Basic blah'})
    end

    it 'should return a list of reminders' do
      @client.reminders
      expect(a_get("reminders")).to have_been_made
    end
  end

  describe '#reminder' do

    before do
      stub_get("reminders/84a49a56-9b71-11e4-87df-cb4dbb25dccc").to_return(body: fixture('reminder.json'), :headers => {:content_type => "application/json; charset=utf-8", authorization: 'Basic blah'})
    end

    it 'should return the selected reminder' do
      @client.reminder('84a49a56-9b71-11e4-87df-cb4dbb25dccc')
      expect(a_get("reminders/84a49a56-9b71-11e4-87df-cb4dbb25dccc")).to have_been_made
    end
  end

end
