require 'spec_helper'
require 'erb'
require 'pathname'
require 'yaml'

# rubocop:disable RSpec/DescribeClass
describe 'Active Storage Configuration' do
  # rubocop:enable RSpec/DescribeClass
  let(:rails_root) { Pathname.new(File.expand_path('../..', __dir__)) }
  let(:config) do
    root = rails_root
    rails_const = Class.new
    rails_const.define_singleton_method(:root) { root }
    stub_const('Rails', rails_const)

    YAML.safe_load(ERB.new(rails_root.join('config/storage.yml').read).result)
  end

  it 'configures checksum handling for S3-compatible storage providers' do
    expect(config.fetch('s3_compatible')).to include(
      'request_checksum_calculation' => 'when_required',
      'response_checksum_validation' => 'when_required'
    )
  end
end
