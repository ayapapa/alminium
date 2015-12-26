require 'spec_helper'

describe file('/etc/opt/alminium/alminium.conf') do
  it { should be_file }
end

describe file('/etc/opt/alminium/redmine.conf') do
  it { should be_file }
end

describe file('/etc/opt/alminium/vcs.conf') do
  it { should be_file }
end

describe file('/etc/opt/alminium/maven.conf') do
  it { should be_file }
end

describe file('/etc/opt/alminium/jenkins.conf') do
  it { should be_file }
end

describe file('/etc/opt/alminium/passenger.conf') do
  it { should be_file }
end

# vim: set ts=2 sw=2 et:
