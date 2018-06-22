def open_file
  files = File.open('alumnos.csv', 'r')
  data = files.readlines
  data = data.map { |e| e.split(', ').map(&:chomp) }
  files.close
  data

end

def cantidad_inasistencia
    open_file.each do |details|
    nombre = details.shift.strip
    inasistencias = details.select { |e| e == 'A' }.count
    puts "El Alumno #{nombre} tiene #{inasistencias} inasistencia"
  end
end

def suma(alum)
  sum = 0
  alum.each do |ele|
    unless ele == 'A'
      sum += ele.to_f
    end
  end
  sum / alum.length
end

def promedio_alumnos
  open_file
  open_file.each do |details|
    name = details.shift.strip
    sum = suma(details)
    File.open('promedio.csv', 'a') { |e| e.puts "El alumno #{name} tiene un promedio de #{sum}"}
  end
  puts '#########################################'
  puts  "EL ARCHIVO CON LOS PROMEDIOS YA FUE CREADO"
  puts '#########################################'
end

def alumnos_aprobados
  files = File.open('alumnos.csv', 'r')
  alumnos = []
  files.each { |line| alumnos.push(line.split(', ').map(&:chomp)) }
  puts "Ingrese una nota minima de aprobación (SI INGRESA ENTER EL LA NOTA SERA 5 POR DEFECTO)"
  nota = gets.chomp

  alumnos.each do |details|
    name = details.shift.strip
    sum = suma(details)
    if nota == ''
      puts "El alumno #{name} tiene un promedio #{sum}" if sum >= 5
    else
      puts "El alumno #{name} tiene un promedio #{sum} y esta Aprobado" if sum >= nota.to_f
    end
  end
end

puts "\n"
puts '########################################################'
puts "\n"
puts "REGISTRO DE ASISTENCIA Y NOTAS DE ALUMNOS", "\n"
puts '########################################################', "\n"
option = 0


while option != 4
  puts "Ingrese 1 para ver el alumno y su promedio de notas"
  puts "ingresa 2 para mostrar la cantidad de inasistencias"
  puts "ingresa 3 para ver lo nombres de los alumnos aprobados"
  puts "ingresa 4 para salir del programa"

  option = gets.chomp.to_i

  case option

  when 1
    promedio_alumnos
  when 2
    cantidad_inasistencia
  when 3
    alumnos_aprobados
  when 4
    puts '###########################'
    puts "USTED A SALIDO DEL PROGRAMA"
    puts '###########################'
    puts "\n"
    exit

  else
    puts "\n"
    puts '######ERROR######'
    puts "\n"
    puts 'Ingrese una opción correcta'
    puts "\n"
  end
end
