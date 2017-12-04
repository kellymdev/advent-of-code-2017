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

  def print_count
    puts count
  end

  private

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
