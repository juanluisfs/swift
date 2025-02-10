// A sensory feedback determined by a variable
.sensoryFeedback(.impact(weight: .heavy), trigger: trigger, condition: { oldValue, newValue in
  variableCondition
})


.sensoryFeedback(.impact(weight: .heavy), trigger: trigger, condition: { oldValue, newValue in
  variableCondition || number == 10
})
