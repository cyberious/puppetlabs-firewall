require 'rubygems'
require 'nokogiri'

module Puppet
  module Util
    class Rule

      VERSION = '0.0.1'
      attr_accessor :chain, :table, :match, :condition, :action

      def initialize(xml)
        @chain = xml.parent.attribute('name').to_s
        @table = xml.parent.parent.attribute('name').to_s
        require 'pry'
        binding.pry
        @action = xml.xpath('./actions').first.element_children.first.name
        @conditions = xml.xpath('/conditions').collect do |condition|
          Puppet::Util::Condition.new(condition)
        end
      end

    end

    class Condition
      attr_accessor :matchs, :comment

      def initialize(xml)
        @comment = xml.xpath("/comment/comment").children.first.to_s
      end
    end
  end
end
