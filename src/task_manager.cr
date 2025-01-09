require "./task"

class TaskManager
  getter tasks : Array(Task)

  def initialize
    @tasks = [] of Task
  end

  def add_task(title : String)
    if @tasks.size >= 30
      puts "You have reached the limit of 30 tasks! Remove a task to add another."
    else
      @tasks << Task.new(title.strip)
      puts "Task '#{title}' added!"
    end
  end

  def remove_task(tag : Int32 | String)
    if tag.is_a?(String)
      i = @tasks.size
      case tag.strip
      when "all"
        @tasks = [] of Task
        puts "All your tasks have been removed! (#{i})"
      when "alld"
        @tasks.reject! { |task| task.done }
        puts "All your completed tasks have been removed! (#{i - @tasks.size})"
      when "allud"
        @tasks.reject! { |task| !task.done }
        puts "All your unfinished tasks have been removed! (#{i - @tasks.size})"
      else
        puts "Task not found!"
      end
    elsif tag.is_a?(Int32)
      if tag >= 0 && tag < @tasks.size
        task = @tasks[tag]
        @tasks.delete_at(tag)
        puts "Task '#{task.title}' removed!"
      else
        puts "Task not found!"
      end
    end
  end

  def edit_task(index : Int32, title : String)
    if index >= 0 && index < @tasks.size
      task = @tasks[index]
      old_title = task.title
      task.title = title.strip
      puts "Task '#{old_title}' was edited to '#{task.title}'!"
    else
      puts "Task not found!"
    end
  end

  def list_tasks
    if @tasks.empty?
      puts "No tasks registered."
    elsif @tasks.each_with_index do |task, index|
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

  def mark_done(tag : Int32 | String)
    if tag.is_a?(String)
      if tag.strip == "all"
        count = 0
        @tasks.each do |task|
          unless task.done
            count += 1
            task.done = true
          end
        end
        puts "All tasks have been marked as done! (#{count})"
      else
        puts "Task not found!"
      end
    elsif tag.is_a?(Int32)
      if tag >= 0 && tag < @tasks.size
        task = @tasks[tag]
        if !task.done
          task.done = true
          puts "Task '#{task.title}' has been marked as done!"
        else
          task_text = total_tasks_done[0].not_nil! > 1 ? "All tasks are already done!" : "The task is already done!"
          puts task_text
        end
      else
        puts "Task not found!"
      end
    end
  end

  def unmark_done(tag : Int32 | String)
    if tag.is_a?(String)
      if tag.strip == "all"
        count = 0
        @tasks.each do |task|
          if task.done
            count += 1
            task.done = false
          end
        end
        puts "All tasks have been marked as not done! (#{count})"
      else
        puts "Task not found!"
      end
    elsif tag.is_a?(Int32)
      if tag >= 0 && tag < @tasks.size
        task = @tasks[tag]
        if task.done
          task.done = false
          puts "Task '#{task.title}' has been marked as not done!"
        else
          task_text = total_tasks_undone[0].not_nil! > 1 ? "All tasks are already not done!" : "The task is already marked as not done!"
          puts task_text
        end
      else
        puts "Task not found!"
      end
    end
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

  def title_available?(title : String) : Tuple(Bool, Int32)
    reserved_names = ["all", "alld", "allud"]
    lower_title = title.downcase

    if title.size > 202
      return {false, 3} # 3 -> greater than 202 characters
    end

    if @tasks.any? { |task| task.title.downcase == lower_title }
      return {false, 1} # 1 -> title already exists
    end

    if reserved_names.includes?(lower_title)
      return {false, 2} # 2 -> reserved name
    end

    return {true, 0} # 0 -> name accepted
  end
end
