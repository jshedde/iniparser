# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_parser.rb


require 'helper'


class TestParser < MiniTest::Test

  def test_load

    text = <<TXT
  # comment
  ; another comment

   key1 = hello
   key2 : hi!

   [section1]
   key3 = salut   # end of line comment here

   [section2]
   key4: hola
   blank =
   blank2:

   [ http://example.com ]
   title =  A rose is a rose is a rose, eh?
   title2:  A rose is a rose is a rose, eh?   # comment here
   ; another one here
   title3 = A rose is a rose is a rose, eh?
TXT

    hash = INI.load( text )
    pp hash

    assert_equal 'hello', hash['key1']
    assert_equal 'hi!',   hash['key2']
    assert_equal 'salut', hash['section1']['key3']
    assert_equal 'hola',  hash['section2']['key4']
    assert_equal '',      hash['section2']['blank']
    assert_equal '',      hash['section2']['blank2']
    assert_equal 'A rose is a rose is a rose, eh?', hash['http://example.com']['title']
    assert_equal 'A rose is a rose is a rose, eh?', hash['http://example.com']['title2']
    assert_equal 'A rose is a rose is a rose, eh?', hash['http://example.com']['title3']
  end

  def test_load_array

    text = <<TXT
   [section1]
   key[] = value0
   key[] = value1
   key2[subkey] = value
   key2[] = value1
TXT

    hash = INI.load( text )
    pp hash

    assert_equal 'value0', hash['section1']['key'][0]
    assert_equal 'value1', hash['section1']['key'][1]
    assert_equal 'value',  hash['section1']['key2']['subkey']
    assert_equal 'value1', hash['section1']['key2'][1]
  end

end
