require 'spec_helper'

describe Oga::XML::Lexer do
  describe 'using HTML <head> elements' do
    it 'lexes an unclosed <head> followed by a <head> as separate elements' do
      lex_html('<head>foo<head>bar').should == [
        [:T_ELEM_NAME, 'head', 1],
        [:T_TEXT, 'foo', 1],
        [:T_ELEM_END, nil, 1],
        [:T_ELEM_NAME, 'head', 1],
        [:T_TEXT, 'bar', 1],
        [:T_ELEM_END, nil, 1]
      ]
    end

    it 'lexes an unclosed <head> followed by a <body> as separate elements' do
      lex_html('<head>foo<body>bar').should == [
        [:T_ELEM_NAME, 'head', 1],
        [:T_TEXT, 'foo', 1],
        [:T_ELEM_END, nil, 1],
        [:T_ELEM_NAME, 'body', 1],
        [:T_TEXT, 'bar', 1],
        [:T_ELEM_END, nil, 1]
      ]
    end

    it 'lexes a <title> following an unclosed <head> as a child element' do
      lex_html('<head><title>foo</title>').should == [
        [:T_ELEM_NAME, 'head', 1],
        [:T_ELEM_NAME, 'title', 1],
        [:T_TEXT, 'foo', 1],
        [:T_ELEM_END, nil, 1],
        [:T_ELEM_END, nil, 1]
      ]
    end
  end
end
