// Sensory feedback determined by a variable
.sensoryFeedback(.impact(weight: .heavy), trigger: trigger, condition: { oldValue, newValue in
  variableCondition
})

// Sensory feedback determined by a group of variables
.sensoryFeedback(.impact(weight: .heavy), trigger: trigger, condition: { oldValue, newValue in
  variableCondition || number == 10
})
