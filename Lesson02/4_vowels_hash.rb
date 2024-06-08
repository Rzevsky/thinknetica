# Заполнить хеш гласными буквами,
# где значением будет являтся порядковый номер буквы в алфавите (a - 1).

keys = (:a..:z).to_a
values = (1..26).to_a
vowels = %i[a e i o u]
vowels_hash = keys.zip(values).to_h.select { |key, _| vowels.include?(key) }
puts vowels_hash.inspect
