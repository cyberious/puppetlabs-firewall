require 'spec_helper'

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib/puppet/util/decoder'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib/puppet/util/rule'))


RSpec.describe Puppet::Util::Decoder do
  let(:subject) { Puppet::Util::Decoder }
  describe 'basic rule' do
    it {
      xml = <<-XML
<iptables-rules version="1.0">
<table name="filter" >
  <chain name="INPUT" policy="ACCEPT" packet-count="0" byte-count="0" >
    <rule >
      <conditions>
        <match >
          <p >icmp</p>
        </match>
        <comment >
          <comment >&quot;000 accept all icmp&quot;</comment>
        </comment>
      </conditions>
      <actions>
        <ACCEPT  />
      </actions>
    </rule>
  </chain>
</table>
</iptables-rules>
      XML

      rules = Puppet::Util::Decoder.load(xml)
      expect(rules).to_not be_empty
      rule1 = rules[0]

      expect(rule1.chain).to eql('INPUT')
      expect(rule1.table).to eql('filter')
      expect(rule1.action).to eql('ACCEPT')
    }
  end


end
