//
//  CoreDataService.swift
//  Recorder
//
//  Created by IgorGalimski on 04/12/2021.
//

import UIKit
import CoreData

enum CoreDataState
{
    case save
    case load
}

class CoreDataService
{
    static let Shared = CoreDataService()
    
    lazy var recordedData: [Recorder] = []
    
    init()
    {
        
    }
    
    func NumberOfItems() -> Int
    {
        return recordedData.count
    }
    
    func AppViewContext() -> NSManagedObjectContext
    {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private func LoadCoreData()
    {
        let fetchRequest: NSFetchRequest<Recorder> = Recorder.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Recorder.date), ascending: false)]
        
        do
        {
            recordedData = try AppViewContext().fetch(fetchRequest)
        }
        catch let error
        {
            print(error)
        }
    }
    
    private func Save()
    {
        do
        {
            try AppViewContext().save()
        }
        catch let error
        {
            print(error)
        }
    }
}
