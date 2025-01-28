func updatingSomething(_ something: somethingData){
        do {
            try context.save()
        } catch {
            print("The file could not be loaded")
        }
    }
    
