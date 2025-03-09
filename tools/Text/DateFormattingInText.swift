// Day Number
Text(Date().formatted(.dateTime.day()))

// Week Number
Text(Date().formatted(.dateTime.week()))

// Weekday Short
Text(Date().formatted(.dateTime.weekday()))

// Weekday Complete
Text(Date().formatted(.dateTime.weekday(.wide)))

// Month Short
Text(Date().formatted(.dateTime.month()))

// Month Complete
Text(Date().formatted(.dateTime.month(.wide)))

// Year (4-Digit)
Text(Date().formatted(.dateTime.year()))

// Day Number with Short Weekday
Text(Date().formatted(.dateTime.day().weekday()))

// Day Number, Short Weekday and Short Month
Text(Date().formatted(.dateTime.day().weekday().month()))

// Day Number, Short Weekday, Short Month adn Year (4-Digit)
Text(Date().formatted(.dateTime.day().weekday().month().year()))
