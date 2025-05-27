#!/usr/bin/env ruby
# main.rb

ns = Namespace.new
ns.require('./foo')

M = 2

puts ns::Foo.m
