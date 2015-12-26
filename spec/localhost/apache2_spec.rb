require 'spec_helper'

if os[:family] == 'Ubuntu'
  puts "apache test on #{os[:family]}."

  describe package('apache2') do
    it { should be_installed }
  end

  describe service('apache2') do
    it { should be_enabled   }
    it { should be_running   }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe file('/etc/apache2/sites-available/alminium.conf') do
    it { should be_file }
  end

  describe file('/etc/apache2/sites-enabled/alminium.conf') do
    it { should be_file }
  end

  describe file('/etc/apache2/mods-available/passenger.load') do
    it { should be_file }
  end

  describe file('/etc/apache2/mods-enabled/passenger.load') do
    it { should be_file }
  end
end

# vim: set ts=2 sw=2 et:
