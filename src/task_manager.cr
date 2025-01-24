require "./task"

# TO DO: Implementar multiplas escolhas em remove_task e testar o que for possivel fazer no código e traduzir o código
# e aplicar clean code e aplicar nivel de acesso na classe.
class TaskManager
  tasks : Array(Task)
  task_id : Int32

  def initialize
    @tasks = [] of Task
    @task_id = 0
    # Lista de nomes diferentes para as tarefas
    task_names = [
      "Comprar pão",
      "Lavar o carro",
      "Estudar Crystal",
      "Fazer exercícios",
      "Caminhar no parque",
      "Preparar o jantar",
      "Organizar documentos",
      "Fazer compras no mercado",
      "Arrumar o guarda-roupa",
      "Planejar a próxima viagem",
      "Escrever no diário",
      "Assistir a um filme",
      "Limpar o quarto",
      "Enviar e-mails atrasados",
      "Meditar por 15 minutos",
      "Atualizar o currículo",
      "Revisar anotações da aula",
      "Trocar as lâmpadas queimadas",
      "Configurar backup do computador",
      "Ler um capítulo de um livro",
      "Regar as plantas",
      "Organizar fotos antigas",
      "Aprender uma nova palavra em outro idioma",
      "Planejar uma reunião",
      "Fazer uma caminhada de 30 minutos",
      "Consertar itens quebrados",
      "Redefinir metas da semana",
    ]

    # Adicionando as tarefas com nomes únicos
    task_names.each do |name|
      @task_id += 1
      @tasks << Task.new(name, @task_id)
    end
  end

  def add_task(title : String)
    if @tasks.size >= 30
      puts "You have reached the limit of 30 tasks! Remove a task to add another."
    else
      @task_id += 1
      title_status = title_available?(title)

      if title_status[0]
        @tasks << Task.new(title.strip, @task_id)
        puts "Task '#{title}' added!"
      else
        puts title_status[1]
      end
    end
  end

  def remove_task(index : Int32)
    if valid_index?(index)
      task = @tasks[index]
      @tasks.delete_at(index)
      puts "Task '#{task.title}' removed!"
    else
      puts "Task not found!"
    end
  end

  def remove_task(input : String)
    case input.strip
    when "all", "1-30"
      count = @tasks.size
      @tasks.clear
      puts "All your tasks have been removed! (#{count})"
    when "alld"
      done_tasks = @tasks.select { |task| task.done }

      if done_tasks.empty?
        puts "No completed tasks."
      else
        count = @tasks.size
        @tasks.reject! { |task| task.done }
        puts "All your completed tasks have been removed! (#{count - @tasks.size})"
      end
    when "allud"
      undone_tasks = @tasks.select { |task| !task.done }

      if undone_tasks.empty?
        puts "No unfinished tasks."
      else
        count = @tasks.size
        @tasks.reject! { |task| !task.done }
        puts "All your unfinished tasks have been removed! (#{count - @tasks.size})"
      end
    else
      remove_task_with_indices(input)
    end
  end

  def remove_task_with_indices(input : String)
    selected_indices = [] of Int32

    input.gsub(" ", "").split(",").each do |segment|
      if match = segment.match(/(\d+)-(\d+)/)
        start_index = match[1].to_i
        end_index = match[2].to_i

        if !valid_range?(start_index, end_index)
          puts "The number range must start from 1 and go up to 30! (1-30)"
          return
        elsif start_index <= end_index
          selected_indices.concat((start_index..end_index).to_a)
        else
          puts "Invalid range (should be in ascending order): #{segment}"
        end
      elsif segment.match(/^\d+$/)
        selected_indices << segment.to_i
      else
        puts "Invalid input ignored: #{segment}"
      end
    end

    selected_indices.uniq!
    selected_indices.sort!
    selected_indices.select! { |index| index < 31 }
    if selected_indices.size > 30
      puts "Error: You selected more than 30 indices (allowed limit: 30)."
      return
    end

    selected_indices.each_with_index do |index, index_in_selected|
      index -= 1
      logic_index = index - index_in_selected
      if index > 29
        puts "The index #{index + 1} exceeds the allowed limit of 30 tasks."
        next
      end

      if logic_index >= 0 && logic_index < @tasks.size
        task = @tasks[logic_index]
        puts "Task #{index + 1} '#{task.title}' successfully deleted!"
        @tasks.delete_at(logic_index)
      else
        puts "Task #{index + 1} not found!"
      end
    end
  end

  def list_tasks
    if @tasks.empty?
      puts "No tasks registered."
    else
      @tasks.each_with_index do |task, index|
        status = task.done ? "[X]" : "[ ]"
        index_format = index <= 8 ? "0#{index + 1}" : index + 1
        puts "#{index_format}. #{status} #{task.title}"
      end
    end
  end

  def list_done_tasks
    done_tasks = @tasks.select { |task| task.done }

    if done_tasks.empty?
      puts "No completed tasks."
    else
      done_tasks.each do |task|
        original_index = @tasks.index(task)
        status = "[X]"
        unless original_index.nil?
          index_format = original_index <= 8 ? "0#{original_index + 1}" : original_index + 1
          puts "#{index_format}. #{status} #{task.title}"
        end
      end
    end
  end

  def list_undone_tasks
    undone_tasks = @tasks.select { |task| !task.done }

    if undone_tasks.empty?
      puts "No unfinished tasks."
    else
      undone_tasks.each do |task|
        original_index = @tasks.index(task)
        status = "[ ]"
        unless original_index.nil?
          index_format = original_index <= 8 ? "0#{original_index + 1}" : original_index + 1
          puts "#{index_format}. #{status} #{task.title}"
        end
      end
    end
  end

  def mark_done(index : Int32)
    if valid_index?(index)
      task = @tasks[index]
      if !task.done
        task.done = true
        puts "Task #{index + 1} '#{task.title}' has been marked as done!"
      else
        puts "The task #{index + 1} is already marked as done!"
      end
    else
      puts "Task #{index + 1} not found!"
    end
  end

  def mark_done(input : String)
    case input.strip
    when "all", "1-#{total_tasks}"
      count = 0
      @tasks.each do |task|
        if !task.done
          task.done = true
          count += 1
        end
      end
      puts "All tasks have been marked as done! (#{count})"
    else
      mark_done_with_indices(input)
    end
  end

  def mark_done_with_indices(input : String)
    selected_indices = [] of Int32

    input.gsub(" ", "").split(",").each do |segment|
      if match = segment.match(/(\d+)-(\d+)/)
        start_index = match[1].to_i
        end_index = match[2].to_i

        if !valid_range?(start_index, end_index)
          puts "The number range must start from 1 and go up to 30! (1-30)"
          return
        elsif start_index <= end_index
          selected_indices.concat((start_index..end_index).to_a)
        else
          puts "Invalid range (should be in ascending order): #{segment}"
        end
      elsif segment.match(/^\d+$/)
        selected_indices << segment.to_i
      else
        puts "Invalid input ignored: #{segment}"
      end
    end

    selected_indices.uniq!
    selected_indices.sort!
    selected_indices.select! { |index| index < 31 }

    if selected_indices.size > 30
      puts "Error: More than 30 indices selected (maximum allowed: 30)."
      return
    end

    selected_indices.each do |index|
      index -= 1
      mark_done(index)
    end
  end

  def unmark_done(index : Int32)
    if valid_index?(index)
      task = @tasks[index]
      if task.done
        task.done = false
        puts "Task #{index + 1} '#{task.title}' has been marked as not done!"
      else
        puts "The task #{index + 1} is already marked as not done!"
      end
    else
      puts "Task #{index + 1} not found!"
    end
  end

  def unmark_done(input : String)
    case input.strip
    when "all", "1-#{total_tasks}"
      count = 0
      @tasks.each do |task|
        if task.done
          task.done = false
          count += 1
        end
      end
      puts "All tasks have been marked as not done! (#{count})"
    else
      unmark_done_with_indices(input)
    end
  end

  def unmark_done_with_indices(input : String)
    selected_indices = [] of Int32

    input.gsub(" ", "").split(",").each do |segment|
      if match = segment.match(/(\d+)-(\d+)/)
        start_index = match[1].to_i
        end_index = match[2].to_i

        if !valid_range?(start_index, end_index)
          puts "The number range must start from 1 and go up to 30! (1-30)"
          return
        elsif start_index <= end_index
          selected_indices.concat((start_index..end_index).to_a)
        else
          puts "Invalid range (should be in ascending order): #{segment}"
        end
      elsif segment.match(/^\d+$/)
        selected_indices << segment.to_i
      else
        puts "Invalid input ignored: #{segment}"
      end
    end

    selected_indices.uniq!
    selected_indices.sort!
    selected_indices.select! { |index| index < 31 }

    if selected_indices.size > 30
      puts "Error: More than 30 indices selected (maximum allowed: 30)."
      return
    end

    selected_indices.each do |index|
      index -= 1
      unmark_done(index)
    end
  end

  def edit_task(index : Int32, title : String, create : Bool = false)
    if valid_index?(index)
      task = @tasks[index]
      old_title = task.title
      new_title = title.strip

      title_status = title_available?(new_title)
      if title_status[0]
        task.title = new_title
        puts "Task #{index + 1} '#{old_title}' was edited to '#{task.title}'!"
      else
        puts title_status[1]
      end
    else
      puts "Task #{index + 1} not found!"
    end
  end

  def edit_order(type : Int32) # TO DO: lembrar de deixar @task como private e editar o manager.task em main.cr para as funções da classe pois ela será privada.
    if type == 1               # Alp
      @tasks.sort_by!(&.title)
      puts "The task list has been ordered alphabetically."
    end

    if type == 2 # Cri
      @tasks.sort_by(&.id)
      puts "The task list has been sorted in order of creation."
    end
  end

  def valid_index?(index : Int32) : Bool
    index >= 0 && index < @tasks.size
  end

  private def valid_range?(start_index : Int32, end_index : Int32) : Bool
    start_index >= 1 && end_index <= 30 && start_index <= end_index
  end

  def has_tasks?
    !@tasks.empty?
  end

  def total_tasks
    @tasks.size
  end

  def total_tasks_done
    tasks_done = @tasks.select { |task| task.done == true }
    if tasks_done.empty?
      return [0, nil]
    else
      return [tasks_done.size, @tasks.index(tasks_done[0])]
    end
  end

  def total_tasks_undone
    tasks_undone = @tasks.select { |task| task.done == false }
    if tasks_undone.empty?
      return [0, nil]
    else
      return [tasks_undone.size, @tasks.index(tasks_undone[0])]
    end
  end

  def title_available?(title : String) : Tuple(Bool, String)
    reserved_names = ["all", "alld", "allud"]
    lower_title = title.downcase

    if !(title =~ /^(?=.*\S\S\S).+$/)
      return {false, "This title is empty or less than 3 characters! Try again with a title that contains letters or numbers."} # 4 -> empty name
    end

    if title.size > 152
      return {false, "This title is longer than 152 characters. Please try again with a shorter title. (Title is #{title.size - 152} characters over the limit)"} # 3 -> greater than 152 characters
    end

    if reserved_names.includes?(lower_title)
      return {false, "This title is not available. Please choose another title!"} # 2 -> reserved name
    end

    if @tasks.any? { |task| task.title.downcase == lower_title }
      return {false, "A task with this title already exists. Please try again with a different title!"} # 1 -> title already exists
    end

    return {true, ""} # 0 -> name accepted
  end

  def sort_alphabetical? : Bool
    @tasks == @tasks.sort_by(&.title)
  end
end
