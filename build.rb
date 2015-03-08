require 'rubygems'
require 'bundler/setup'

require 'html/pipeline'
require 'pygments'

pipeline = HTML::Pipeline.new([
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::SanitizationFilter,
  HTML::Pipeline::ImageMaxWidthFilter,
  HTML::Pipeline::MentionFilter,
  HTML::Pipeline::EmojiFilter,
  HTML::Pipeline::SyntaxHighlightFilter,
  HTML::Pipeline::TableOfContentsFilter,
  HTML::Pipeline::AutolinkFilter
], { :gfm => true, :asset_root => "http://ryandaigle.com" })

# pipeline = HTML::Pipeline.new [
#   HTML::Pipeline::MarkdownFilter,
#   HTML::Pipeline::SyntaxHighlightFilter
# ]

Dir.glob("content/*.md") do |filename|
  print "Processing #{filename}... "
  result = pipeline.call(File.read(filename))
  output_filename = "output/#{File.basename(filename, '.*')}.html"
  File.open(output_filename, 'w') { |file| file.write(result[:output]) }
  puts "written to #{output_filename}"
end
