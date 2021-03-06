def name_matcher(arr, name)
  first_and_last = Hash.new(false)
  middle_names = Hash.new(false)
  names = name.split(' ')

  # assign trues to first and last name. we can safely assume the 
  # name length will be 2 names at this point based upon the constraints
  arr.each do |full_name|
    poss_name = full_name.split(' ')

    if poss_name.length == 3
      f_name = poss_name[0]
      m_name = poss_name[1]
      l_name = poss_name[2]

      middle_names[m_name] = true
      first_and_last[f_name] = true
      first_and_last[l_name] = true
    else
      poss_name.each do |n|
        first_and_last[n] = true
      end
    end
  end

  count = 0
  if names.length == 3 
    # we have a middle name given so extra checks
    if (middle_names.keys.none? do |m_name| 
          m_name.index(names[1]) || names[1].index(m_name) 
        end) &&
       (first_and_last.keys.none? do |m_name| 
          m_name.index(names[1]) || names[1].index(m_name)
        end) &&
      !middle_names.empty? 
      return false
    end
    count += 1 if first_and_last[names[0]] || middle_names[names[0]]
    count += 1 if first_and_last[names[2]]
  else
    # no middle names
    count += 1 if first_and_last[names[0]]
    count += 1 if first_and_last[names[1]]
  end

  count >= 2
end



known_aliases = ["Alphonse Gabriel Capone", "Al Capone"]
p name_matcher(known_aliases, "Alphonse Gabriel Capone") == true
p name_matcher(known_aliases, "Al Capone") == true
p name_matcher(known_aliases, "Alphonse Francis Capone") == false

known_aliases = ['Alphonse Capone'];
p name_matcher(known_aliases, 'Alphonse Gabriel Capone') === true #
p name_matcher(known_aliases, 'Alphonse Francis Capone') === true #
p name_matcher(known_aliases, 'Alexander Capone') === false

known_aliases = ['Alphonse Gabriel Capone']
p name_matcher(known_aliases, 'Alphonse Gabriel Capone') == true
p name_matcher(known_aliases, 'Al Capone') == false
p name_matcher(known_aliases, 'Alphonse Francis Capone') == false

known_aliases = ['Alphonse Gabriel Capone', 'Alphonse Francis Capone']
p name_matcher(known_aliases, 'Alphonse Gabriel Capone') == true
p name_matcher(known_aliases, 'Alphonse Francis Capone') == true
p name_matcher(known_aliases, 'Alphonse Edward Capone') == false

known_aliases = ['Alphonse Gabriel Capone', 'Alphonse F Capone']
p name_matcher(known_aliases, 'Alphonse G Capone') == true
p name_matcher(known_aliases, 'Alphonse Francis Capone') == true
p name_matcher(known_aliases, 'Alphonse E Capone') == false
p name_matcher(known_aliases, 'Alphonse Edward Capone') == false
p name_matcher(known_aliases, 'Alphonse Gregory Capone') == false

known_aliases = ['Alphonse Gabriel Capone']
p name_matcher(known_aliases, 'Gabriel Alphonse Capone') == true
p name_matcher(known_aliases, 'Gabriel A Capone') == true
p name_matcher(known_aliases, 'Gabriel Al Capone') == true #
p name_matcher(known_aliases, 'Gabriel Francis Capone') == false

known_aliases = ['Alphonse Gabriel Capone']
p name_matcher(known_aliases, 'Alphonse Capone Gabriel') == false
p name_matcher(known_aliases, 'Capone Alphonse Gabriel') == false
p name_matcher(known_aliases, 'Capone Gabriel') == false
