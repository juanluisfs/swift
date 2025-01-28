func updatingSomething(_ something: somethingData){
        do {
            try context.save()
                // Code to execute if there is no error
        } catch {
            print("The file could not be loaded")
                // Code to execute if there is an error
        }
    }
    
