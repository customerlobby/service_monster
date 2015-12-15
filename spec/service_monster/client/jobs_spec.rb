require 'spec_helper'

RSpec.describe ServiceMonster::Client::Jobs do
  
  before do
    @client = ServiceMonster::Client.new
  end

  describe '#jobs' do

    before do
      stub_get("jobs").to_return(body: fixture('jobs_list.json'), :headers => {:content_type => "application/json; charset=utf-8", authorization: 'Basic blah'})
    end

    it 'should return a list of jobs' do
      @client.jobs
      expect(a_get("jobs")).to have_been_made
    end
  end

  describe '#job' do

    before do
      stub_get("jobs/c300d933-723f-11e3-b8c3-d9b28ac835cd").to_return(body: fixture('job.json'), :headers => {:content_type => "application/json; charset=utf-8", authorization: 'Basic blah'})
    end

    it 'should return the selected job' do
      @client.job('c300d933-723f-11e3-b8c3-d9b28ac835cd')
      expect(a_get("jobs/c300d933-723f-11e3-b8c3-d9b28ac835cd")).to have_been_made
    end
  end

end
