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
    puts "7. Edit task order" if manager.total_tasks > 1
    puts "0. Exit"
    print "Choose an option: "

    input = gets
    puts ""
    unless input.nil?
      unless input.chomp.strip =~ /^\d+$/
        puts "Please enter a valid number."
        next
      end

      choice = input.chomp.strip.to_i

      if !manager.has_tasks? && choice > 1
        puts "Invalid option. Please try again."
        sleep(2.seconds)
        next
      end

      case choice
      when 1
        puts "\n[No answer? Press Enter]"
        print " Enter task title: "
        title_input = gets
        if title_input && !title_input.empty?
          title = title_input.chomp

          manager.add_task(title)
        end
      when 2
        if manager.total_tasks == 1
          manager.remove_task(0)
        else
          manager.list_tasks
          puts "\n[No answer? Press Enter]"
          puts "To remove a task, select an option below:"
          puts "'all' -> to remove all tasks"
          puts "'alld' -> to remove all completed tasks"
          puts "'allud' -> to remove all unfinished tasks"
          puts "For multiple choices, use n,n,n (1,2,3...) or n-n (1-3)"
          puts "Or enter the task number you want to remove."
          print " Enter the task number or the option to remove: "
          tag_input = gets
          if tag_input && !tag_input.empty?
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

        if tasks_undone_count.not_nil! == 0
          puts "No tasks were found registered as undone!"
        elsif !tasks_undone_count.nil? && tasks_undone_count <= 1
          manager.mark_done(first_task_index.nil? ? 0 : first_task_index)
        else
          manager.list_undone_tasks
          puts "\n[No answer? Press Enter]"
          puts "To mark as done a task, select an option below:"
          puts "'all' -> mark as done all tasks"
          puts "For multiple choices, use n,n,n (1,2,3...) or n-n (1-3)"
          puts "Or enter the task number you want to mark as done."
          print " Enter the task number or the option to mark as done: "

          tag_input = gets
          if tag_input && !tag_input.empty?
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

        if tasks_done_count.not_nil! <= 0
          puts "No tasks were found registered as done!"
        elsif !tasks_done_count.nil? && tasks_done_count <= 1
          manager.unmark_done(first_task_index.nil? ? 0 : first_task_index)
        else
          manager.list_done_tasks
          puts "\n[No answer? Press Enter]"
          puts "To unmark as done a task, select an option below:"
          puts "'all' -> unmark as done all tasks"
          puts "For multiple choices, use n,n,n (1,2,3...) or n-n (1-3)"
          puts "Or enter the task number you want to unmark as done."
          print " Enter the task number or the option to unmark as done: "
          tag_input = gets
          if tag_input && !tag_input.empty?
            tag = tag_input.chomp
            unless tag =~ /^\d+$/
              manager.unmark_done(tag)
            else
              manager.unmark_done(tag.to_i - 1)
            end
          end
        end
      when 6
        if manager.total_tasks == 1
          puts "\n[No answer? Press Enter]"
          print " Enter the new task title: "
          title_input = gets
          if title_input && !title_input.empty?
            title = title_input.chomp

            manager.edit_task(0, title)
          end
        else
          manager.list_tasks
          puts "\n[No answer? Press Enter]"
          print " Enter the task number to edit: "
          index_input = gets
          if index_input && !index_input.empty?
            index = index_input.chomp.to_i - 1

            print "\n Enter the new task title: "
            title_input = gets
            if title_input
              title = title_input.chomp

              if !manager.valid_index?(index)
                puts "Task #{index + 1} not found! Do you want to create a task with that name? Yes [y] or No [n]?"
                create_input = gets
                if create_input && !create_input.empty?
                  create = create_input.chomp.strip.downcase == "y"
                  if create
                    manager.add_task(title)
                  else
                    puts "Task #{index + 1} was not created!"
                  end
                end
              else
                manager.edit_task(index, title)
              end
            end
          end
        end
      when 7
        puts "\n[No answer? Press Enter]"
        puts "You can select two types of sorting"
        puts "'alp' #{manager.sort_alphabetical? ? "(current) " : ""}-> to organize your list alphabetically"
        puts "'cri' #{!manager.sort_alphabetical? ? "(current) " : ""}-> to organize your list by criation order"
        print " Enter the sorting type: "
        sort_input = gets
        if sort_input && !sort_input.empty?
          sort = sort_input.chomp
          if sort.strip == "alp"
            if manager.sort_alphabetical?
              puts "The list is already in alphabetical order!"
            else
              manager.edit_order(1)
            end
          elsif sort.strip == "cri"
            unless manager.sort_alphabetical?
              puts "The list is already in order of creation!"
            else
              manager.edit_order(2)
            end
          else
            puts "Invalid sorting type. Please try again."
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

def message_title_edit(manager : TaskManager, index : Int32, editable : Bool = true)
end
