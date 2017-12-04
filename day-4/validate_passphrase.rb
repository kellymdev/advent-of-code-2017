class ValidatePassphrase
  attr_reader :passphrases
  attr_accessor :count

  def initialize(passphrases)
    @passphrases = passphrases
    @count = 0
  end

  def count_valid_passphrases
    passphrase_list.each do |passphrase|
      increment_count if valid_passphrase?(passphrase)
    end
  end

  def count_secure_passphrases
    passphrase_list.each do |passphrase|
      formatted = format_passphrase(passphrase)
      increment_count if valid_passphrase?(formatted)
    end
  end

  def print_count
    puts count
  end

  private

  def format_passphrase(passphrase)
    passphrase.split(' ').map do |word|
      word.chars.sort!.join
    end.join(' ')
  end

  def increment_count
    @count += 1
  end

  def valid_passphrase?(passphrase)
    passphrase_array = passphrase.split(' ')
    passphrase_array.uniq == passphrase_array
  end

  def passphrase_list
    passphrases.split("\n")
  end
end
