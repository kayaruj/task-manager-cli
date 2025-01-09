
# 📝 Task Manager Application

Welcome to the **Task Manager**! This is a command-line application built to help you manage your tasks effectively. With this app, you can add, remove, list, edit, and mark tasks as done or undone. 🚀

---

## 🎯 Features
- **Add Tasks**: Create new tasks with unique titles.
- **Remove Tasks**: Delete specific tasks, all tasks, only completed tasks, or only unfinished tasks.
- **List Tasks**: View all tasks with their completion status.
- **Mark as Done**: Mark tasks as completed.
- **Unmark as Done**: Mark completed tasks as not done.
- **Edit Task Title**: Update the title of any task.
- **Exit**: Close the application.

---

## 🛠️ How to Use

### 1️⃣ Start the Application
Run the script in your terminal:
```bash
shards run
```

# 2️⃣ Menu Options

Once the application starts, you will see a menu like this:

```
 === Task Manager ===
1. Add task
2. Remove task
3. List tasks
4. Mark task as done
5. Unmark task as done
6. Edit task title
0. Exit
```

🗂️ **Menu Actions**

1. **Add Task**
   - Enter a title for your task. The app will ensure the title is unique and valid.

2. **Remove Task**
   - Options for removing tasks:
     - `'all'`: Remove all tasks.
     - `'alld'`: Remove only completed tasks.
     - `'allud'`: Remove only unfinished tasks.
     - Or provide a task number to remove a specific task.

3. **List Tasks**
   - Displays all tasks with their completion status:
     - `[X]`: Completed
     - `[ ]`: Not completed

4. **Mark Task as Done**
   - Options for marking tasks as done:
     - `'all'`: Mark all tasks as done.
     - Enter the task number to mark a specific task.

5. **Unmark Task as Done**
   - Options for unmarking tasks as done:
     - `'all'`: Unmark all tasks.
     - Enter the task number to unmark a specific task.

6. **Edit Task Title**
   - Update the title of any task. Provide the task number and the new title.

0. **Exit**
   - Exit the Task Manager application.

---

⚙️ **Application Behavior**

- The app ensures task titles are **unique** and don't exceed **202 characters**.
- Reserved titles like `'all'`, `'alld'`, and `'allud'` cannot be used as task titles.
- The app supports a maximum of **30 tasks**.

---

📋 **Example Usage**

**Adding a Task**
```
Enter task title: Finish homework
Task 'Finish homework' added!
```

**Listing Tasks**
```
01. [ ] Finish homework
02. [X] Go shopping
```

**Marking as Done**
```
Enter the task number or the option to mark as done: 1
Task 'Finish homework' marked as done!
```

**Removing Completed Tasks**
```
Enter the task number or the option to remove: alld
All your completed tasks have been removed! (1)
```

---

💻 **System Requirements**

- **Crystal Language**: Ensure Crystal is installed on your system.  
  Installation guide: [crystal lang](https://crystal-lang.org/install)

---

🎉 **Enjoy!**

Manage your tasks efficiently and never forget what needs to be done. Happy organizing! 🎊

### Credits
- 💡 Code idea: ChatGPT
- 🍬 Developer and author: Balah7
