Button("Done!") {
  tasks.removeAll(where: {$0.name == task.name })
}
