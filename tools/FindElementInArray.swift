// Example #1 - Ejemplo #1
let arr:Array = ["a","b","c"]
find(arr, "c")!              // 2
find(arr, "d")               // nil


// Example #2 - Ejemplo #2
let arr = ["a","b","c","a"]

let indexOfA = arr.firstIndex(of: "a")  // 0
let indexOfB = arr.lastIndex(of: "a")   // 3


// Example #3 - Searching index in classes
// Ejemplo #3 - Buscar índice en clases
let person1 = Person(name: "John")
let person2 = Person(name: "Sue")
let person3 = Person(name: "Maria")
let person4 = Person(name: "Loner")

let people = [person1, person2, person3]

let indexOfPerson1 = people.firstIndex{$0 === person1} // 0
let indexOfPerson2 = people.firstIndex{$0 === person2} // 1
let indexOfPerson3 = people.firstIndex{$0 === person3} // 2
let indexOfPerson4 = people.firstIndex{$0 === person4} // nil
