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
    
    lazy var recordedData: [Recorded] = []
    
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
    
    public func LoadCoreData()
    {
        let fetchRequest: NSFetchRequest<Recorded> = Recorded.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Recorded.date), ascending: false)]
        
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
