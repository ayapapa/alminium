require 'spec_helper'

if os[:family] == 'RedHat'
  puts "apache test on #{os[:family]}."

  describe package('httpd') do
    it { should be_installed }
  end

  describe service('httpd') do
    it { should be_enabled   }
    it { should be_running   }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe file('/etc/httpd/conf.d/alminium.conf') do
    it { should be_file }
  end

  describe file('/etc/httpd/conf.d/passenger.conf') do
    it { should be_file }
  end
end

# vim: set ts=2 sw=2 et:
