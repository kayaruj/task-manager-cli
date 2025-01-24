
# 📝 Task Manager Application

Welcome to the **Task Manager**! This is a command-line application built to help you manage your tasks effectively. With this app, you can add, remove, list, edit, and mark tasks as done or undone. 🚀

---

## 🌟 Features 

#### 1. Add Task ➕
Add a new task to the list with a unique title:
- The title is checked to prevent duplicates.
- Maximum limit of 30 tasks in the list.

#### 2. Remove Task(s) ❌
Options available:
- Remove a specific task by number.
- Remove all tasks.
- Remove all completed tasks.
- Remove all pending tasks.
- Remove multiple tasks using:
  - A range (e.g., `1-5`).
  - A list (e.g., `1,3,5`).

#### 3. List Tasks 📋
Display all tasks with their status:
- `[ ]` - Pending task.
- `[X]` - Completed task.

#### 4. Mark as Completed ✅
Mark one or more tasks as completed:
- Option to mark all tasks.
- Multiple selection using ranges or lists.

#### 5. Unmark as Completed 🔄
Unmark one or more completed tasks:
- Option to unmark all completed tasks.
- Multiple selection using ranges or lists.

#### 6. Edit Task Title ✏️
Edit the title of an existing task:
- If the task is not found, you will be asked whether to create a new one with the given title.

#### 7. Sort Tasks 🔀
Reorder the task list:
- **Alphabetical** (`alp`): Sort tasks alphabetically.
- **Creation Order** (`cri`): Restore original creation order.

---

## 🛠️ How to Use

#### 1️⃣ Clone the Repository
Run the script in your terminal:
```bash
   git clone https://github.com/balah7/task-manager-cli
   cd task-manager
```

#### 2️⃣ Start the Application
Run the script in your terminal:
```bash
shards run
```

## 2️⃣ Menu Options

Once the application starts, you will see a menu **like this**:

```
 === Task Manager ===
 1. Add task
 2. Remove task (if tasks exist)
 3. List tasks (if tasks exist)
 4. Mark task as done (if tasks exist)
 5. Unmark task as done (if tasks exist)
 6. Edit task title (if tasks exist)
 7. Edit task order (if more than 1 task exists)
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
     - For multiple choices, use `'n,n,n'` (1,2,3...) or `'n-n'` (1-3)
     - Or provide a task number to remove a specific task.

3. **List Tasks**
   - Displays all tasks with their completion status:
     - `[X]`: Completed
     - `[ ]`: Not completed

4. **Mark Task as Done**
   - Options for marking tasks as done:
     - `'all'`: Mark all tasks as done.
     - For multiple choices, use `'n,n,n'` (1,2,3...) or `'n-n'` (1-3)
     - Enter the task number to mark a specific task.

5. **Unmark Task as Done**
   - Options for unmarking tasks as done:
     - `'all'`: Unmark all tasks.
     - For multiple choices, use `'n,n,n'` (1,2,3...) or `'n-n'` (1-3)
     - Enter the task number to unmark a specific task.

6. **Edit Task Title**
   - Update the title of any task. Provide the task number and the new title.

7. **Edit Task Order**
   - Options for ordering tasks:
   - `'alp'`: Organize the to-do list alphabetically.
   - `'cri'` (Standard): Organize the to-do list in order of date created
   - Enter the sort type to organize the tasks.

0. **Exit**
   - Exit the Task Manager application.

---

⚙️ **Application Behavior**

- The app ensures task titles are **unique**, have a *minimum of 3 characters*, and don't exceed **152 characters**.
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


🏗️ **Code Structure** 

- **`main.cr`**: The main file where the menu and interaction logic are defined.
- **`task_manager.cr`**: Handles task logic, including adding, removing, listing, marking/unmarking, and sorting.
- **`task.cr`**: Defines the `Task` class, representing a task with a title, status, and ID.

---

💻 **System Requirements**

- **Crystal Language**: Ensure Crystal is installed on your system.  
ㅤInstallation guide: [Crystal Lang](https://crystal-lang.org/install)
- Interactive **terminal** environment.
---

🎉 **Enjoy!**

Manage your tasks efficiently and never forget what needs to be done. Happy organizing! 🎊
(*Application made only to test knowledge in Crystal language.*)

### Credits
- 💡 Code idea: ChatGPT
- 🍬 Developer and author: [Balah7](https://github.com/balah7)

~333~