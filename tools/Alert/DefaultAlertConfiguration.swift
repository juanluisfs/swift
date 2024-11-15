/// content ...  
.alert(  
    "Random Book",  
    isPresented: $showAlert,  
    presenting: randomBook  
) { book in  
    Button("Yes, Done") {  
        selectedBook = book  
    }  
} message: { book in  
    Text("You have selected \(book.title) by \(book.author)")  
}  
.alert(  
    "Credits",  
    isPresented: $showCreditAlert  
) {  
    Button("OK") {}  
} message: {  
    Text("This custom alert tutorial was implemented by **Marwa**.")  
}
