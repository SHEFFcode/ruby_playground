first_name = 'Josh'
last_name = 'Brickman'
full_name = ''

full_name << first_name if first_name
full_name << ' '
full_name << last_name if last_name

p full_name