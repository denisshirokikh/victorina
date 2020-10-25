require 'rexml/document'

module Parser

  def self.from_file(file_path)
    # file = File.new("#{__dir__}/data/data.xml", encoding: 'UTF-8')
    file = File.new(file_path)
    doc = REXML::Document.new(file)
    file.close

    doc.elements['questions'].elements.map do |item|
      right_answer = ''
      item.elements.each('./variants/variant/') { |variant| right_answer = variant.text if variant.attributes['right'] }
      Victorina.new(
          item.elements['text'].text,
          right_answer,
          item.attributes['points'].to_s,
          item.attributes['minutes'].to_s,
          item.elements['variants'].elements.map(&:text)
      )
    end
  end
end
