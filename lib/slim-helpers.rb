require 'openssl'
require 'base64'
require 'nokogiri'

module Slim::Helpers

  def ietf_language_tag(lang)
    if lang == 'zh'
      'zh-Hans'
    else
      lang.to_s
    end
  end

  def native_language_name(lang)
    {
      'zh' => '中文',
      'en' => 'English',
    }[lang]
  end

  def for_each_lang(&block)
    %w(zh en).map(&block).join('')
  end

  def path_with_cache_id(path)
    file_content = File.read File.join('.', path)
    hash = OpenSSL::Digest::SHA256.new.digest(file_content)
    cache_id = Base64.urlsafe_encode64(hash, padding: false)[0..7]
    "#{path}?fc=#{cache_id}"
  end

  def extract_preamble(content)
    doc = Nokogiri::HTML(content)
    doc.css('#preamble')[0].to_s
  end

  def remove_preamble(content)
    doc = Nokogiri::HTML(content)
    doc.css('#preamble')[0].remove
    doc.to_s
  end

end
