# frozen_string_literal: true

require 'erb'

class FormLetterService
  attr_reader :letter, :name, :legislators

  def initialize(name:, legislators:)
    @name = name
    @legislators = legislators
    @letter = template_letter
  end

  def save_letter(id)
    Dir.mkdir('output') unless Dir.exist?('output')

    filename = "output/thanks_#{id}.html"

    File.open(filename, 'w') { |file| file.puts letter }
  end

  private

  def template_letter
    template_letter = File.read('lib/form_letter.erb')
    erb_template = ERB.new template_letter

    erb_template.result(binding)
  end
end
