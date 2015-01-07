require 'rubygems'
require 'nokogiri'

module Puppet
  module Util
    class Decoder
      attr_reader :opts

      def self.load(xml, opts = {})
        iptables = Nokogiri::XML(xml)
        rules = []
        iptables.xpath('//rule').collect do |rule|
          rules << Puppet::Util::Rule.new(rule)
        end
        rules
      end
    end
  end
end
