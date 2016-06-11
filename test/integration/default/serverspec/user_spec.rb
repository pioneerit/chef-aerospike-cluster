require 'spec_helper'

describe 'aerospike-cluster::user' do
  describe group('aerospike') do
    it { should exist }
  end
  describe user('aerospike') do
    it { should exist }
    it { should belong_to_group 'aerospike' }
    it { should have_login_shell '/bin/false' }
  end
end
