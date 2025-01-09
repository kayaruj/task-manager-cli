require "./task_manager"

def start
  manager = TaskManager.new

  while true
    puts "\n === Task Manager ==="
    puts "1. Add task"
    if manager.has_tasks?
      puts "2. Remove task"
      puts "3. List tasks"
      puts "4. Mark task as done"
      puts "5. Unmark task as done"
      puts "6. Edit task title"
    end
    puts "0. Exit"
    print "Choose an option: "

    input = gets
    puts ""
    unless input.nil?
      unless input =~ /^\d+$/
        puts "Please enter a valid number."
        next
      end

      choice = input.chomp.to_i

      if !manager.has_tasks? && choice > 1
        puts "Invalid option. Please try again."
        sleep(2.seconds)
        next
      end

      case choice
      when 1
        print "\n Enter task title: "
        title_input = gets
        if title_input
          title = title_input.chomp
          if manager.title_available?(title)[0]
            manager.add_task(title)
          else
            if manager.title_available?(title)[1] == 1
              puts "A task with this title already exists. Please try again with a different title!"
            end

            if manager.title_available?(title)[1] == 2
              puts "This title is not available. Please choose another title!"
            end

            if manager.title_available?(title)[1] == 3
              puts "This title is longer than 202 characters. Please try again with a shorter title. (Title is #{title.size - 202} characters over the limit)"
            end
          end
        end
      when 2
        if manager.tasks.size == 1
          manager.remove_task(0)
        else
          manager.list_tasks
          puts "\nTo remove a task, select an option below:"
          puts "'all' -> to remove all tasks"
          puts "'alld' -> to remove all completed tasks"
          puts "'allud' -> to remove all unfinished tasks"
          puts "Or enter the task number you want to remove"
          print " Enter the task number or the option to remove: "
          tag_input = gets
          if tag_input
            tag = tag_input.chomp
            unless tag =~ /^\d+$/
              manager.remove_task(tag)
            else
              manager.remove_task(tag.to_i - 1)
            end
          end
        end
      when 3
        manager.list_tasks
      when 4
        tasks_undone_count, first_task_index = manager.total_tasks_undone

        if !tasks_undone_count.nil? && tasks_undone_count <= 1
          manager.mark_done(first_task_index.nil? ? 0 : first_task_index)
        else
          manager.list_undone_tasks
          puts "\nTo mark as done a task, select an option below:"
          puts "'all' -> mark as done all tasks"
          puts "Or enter the task number you want to mark as done"
          print " Enter the task number or the option to mark as done: "
          tag_input = gets
          if tag_input
            tag = tag_input.chomp
            unless tag =~ /^\d+$/
              manager.mark_done(tag)
            else
              manager.mark_done(tag.to_i - 1)
            end
          end
        end
      when 5
        tasks_done_count, first_task_index = manager.total_tasks_done

        if !tasks_done_count.nil? && tasks_done_count <= 1
          manager.unmark_done(first_task_index.nil? ? 0 : first_task_index)
        else
          manager.list_done_tasks
          puts "\nTo unmark as done a task, select an option below:"
          puts "'all' -> unmark as done all tasks"
          puts "Or enter the task number you want to unmark as done"
          print " Enter the task number or the option to unmark as done: "
          tag_input = gets
          if tag_input
            tag = tag_input.chomp
            unless tag =~ /^\d+$/
              manager.unmark_done(tag)
            else
              manager.unmark_done(tag.to_i - 1)
            end
          end
        end
      when 6
        if manager.tasks.size == 1
          print "\n Enter the new task title: "
          title_input = gets
          if title_input
            title = title_input.chomp
            if manager.title_available?(title)[0]
              manager.edit_task(0, title)
            else
              if manager.title_available?(title)[1] == 1
                puts "A task with this title already exists. Please try again with a different title!"
              end

              if manager.title_available?(title)[1] == 2
                puts "This title is not available. Please choose another title!"
              end

              if manager.title_available?(title)[1] == 3
                puts "This title is longer than 202 characters. Please try again with a shorter title. (Title is #{title.size - 202} characters over the limit)"
              end
            end
          end
        else
          manager.list_tasks
          print "\n Enter the task number to edit: "
          index_input = gets
          if index_input
            index = index_input.chomp.to_i - 1
            print "\n Enter the new task title: "
            title_input = gets
            if title_input
              title = title_input.chomp
              if manager.title_available?(title)[0]
                manager.edit_task(index, title)
              else
                if manager.title_available?(title)[1] == 1
                  puts "A task with this title already exists. Please try again with a different title!"
                end

                if manager.title_available?(title)[1] == 2
                  puts "This title is not available. Please choose another title!"
                end

                if manager.title_available?(title)[1] == 3
                  puts "This title is longer than 202 characters. Please try again with a shorter title. (Title is #{title.size - 202} characters over the limit)"
                end
              end
            end
          end
        end
      when 0
        puts "Exiting Task Manager..."
        break
      else
        puts "Invalid option. Please try again."
      end
      sleep(3.seconds)
    end
  end
end

start()
