# coding: utf-8
require 'spec_helper'
require 'poseidon/partition_hasher'

RSpec.describe PartitionHasher do
  it 'should spread between 50 buckets matching Java implementation' do
    # The values below are generated using the Java Kafka client, via the
    # test class HashingTest.java. See instructions therein; it generates
    # lines that can be pasted right in here.
    test_cases = {'foobar' => 16 ,
                  'baz' => 30 ,
                  'rm-foo' => 45 ,
                  'yello' => 43 ,
                  'poseidon says hi' => 29 ,
                  'Здравствуй, мир!' => 37 ,
                  '你好世界' => 37 ,
                  'こんにちは世界' => 12 ,
                  '' => 31 ,
                  ' ' => 21 ,
                  '  ' => 5 ,
                  '   ' => 2 ,
                  '    ' => 44 ,
                 }
    hasher = PartitionHasher.new 50
    test_cases.each do |key, expected_part|
      part = hasher.partition_for key
      expect(part).to eq(expected_part)
    end
  end

  it 'should handle a one partition case well' do
    rnd = Random.new RSpec.configuration.seed
    hasher = PartitionHasher.new 1
    100.times do |size|
      key = rnd.bytes(size)
      expect(hasher.partition_for key).to eq(0)
    end
  end
    
end
