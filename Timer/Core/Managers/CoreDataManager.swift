//
//  DBManager.swift
//  CoreDataWorkbook
//
//  Created by Dmitry Lernatovich on 17.07.2020.
//

/*
 Add to SceneDelegate this code
 func sceneDidEnterBackground(_ scene: UIScene) {
 CoreDataManager.save();
 }
 */

import Foundation
import CoreData

/// Database name
private var kDatabaseName: String { return "Timer" }
/// Database extension name
private var kDatabaseExtension: String { return "momd" }

/// Database manager
public class CoreDataManager {
    
    /// Instance of the DBManager
    private static let shared: CoreDataManager = CoreDataManager();
    
    /// Instance of the {@link DispatchGroup}
    fileprivate let dispatchGroup: DispatchGroup = DispatchGroup();
    
    /// Persistance container
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let modelURL = Bundle(for: type(of: self))
            .url(forResource: kDatabaseName,
                 withExtension: kDatabaseExtension)!;
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL);
        let container = NSPersistentContainer(name: kDatabaseName,
                                              managedObjectModel: managedObjectModel!);
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("Loading of store failed:\(err)");
            }
        }
        return container;
    }();
    
    
    /// Instance of the {@link NSManagedObjectContext}
    fileprivate var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext;
    }
    
}

/// Persistance container
public extension CoreDataManager {
    
    /// Save functional
    static func save() {
        shared.saveInternal();
    }
    
    /// Method which provide the save functional
    fileprivate func saveInternal() {
        dispatchGroup.enter();
        if self.managedContext.hasChanges {
            do {
                try self.managedContext.save();
                dispatchGroup.leave();
            } catch {
                let nserror = error as NSError;
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)");
            }
        }
    }
}

/// MARK: - Create model functional
public extension CoreDataManager {
    
    /// Method which provide the force create model functional
    /// - Parameters:
    ///   - name: name of the entity
    ///   - performHandler: perform action callback
    static func create<T: NSManagedObject>(
        name: String,
        performHandler: (_ model: T) -> Void
    ) {
        shared.createInternal(name: name, performHandler: performHandler);
    }
    
    
    /// Method which provide the create model or update existed
    /// - Parameters:
    ///   - name: entity name
    ///   - predicate: predicate for search
    ///   - performHandler: perform handler
    static func createOrUpdate<T: NSManagedObject>(
        name: String,
        predicate: NSPredicate? = nil,
        performHandler: (_ model: T) -> Void
    ) {
        shared.createInternal(name: name, predicate: predicate, performHandler: performHandler);
    }
    
    
    /// Method which provide the create model or update existed
    /// - Parameters:
    ///   - name: entity name
    ///   - predicate: predicate for search
    ///   - performHandler: perform handler
    fileprivate func createInternal<T: NSManagedObject>(name: String,
                                                             predicate: NSPredicate? = nil,
                                                             performHandler: (_ model: T) -> Void) {
        let exists: T? = (predicate != nil)
            ? self.getItemInternal(name: name, predicate: predicate)
            : nil;
        if let model = exists {
            performHandler(model);
        } else {
            let entity = NSEntityDescription.entity(forEntityName: name, in: managedContext)!;
            let model = T(entity: entity, insertInto: self.managedContext);
            performHandler(model);
        }
        saveInternal();
    }
    
}

/// Get items
public extension CoreDataManager {
    
    /// Method which provide the getting model
    /// - Parameters:
    ///   - name: name of the entity
    ///   - predicate: search predicate value
    /// - Returns: object instance
    static func getItem<T:NSManagedObject>(
        name: String,
        predicate: NSPredicate? = nil
    ) -> T? {
        return shared.getItemInternal(name: name, predicate: predicate);
    }
    
    /// Method which provide the load models
    /// - Parameters:
    ///   - name: name of the entity
    ///   - predicate: predicate value
    /// - Returns: list of the models
    static func getItems<T:NSManagedObject>(
        name: String,
        predicate: NSPredicate? = nil
    ) -> [T] {
        return shared.getItemsInternal(name: name, predicate: predicate);
    }
    
    /// Method which provide the getting model
    /// - Parameters:
    ///   - name: name of the entity
    ///   - predicate: search predicate value
    /// - Returns: object instance
    fileprivate func getItemInternal<T:NSManagedObject>(
        name: String,
        predicate: NSPredicate? = nil
    ) -> T? {
        return getItemsInternal(name: name, predicate: predicate).first;
    }
    
    /// Method which provide the load models (internally)
    /// - Parameters:
    ///   - name: name of the entity
    ///   - predicate: predicate value
    /// - Returns: list of the models
    fileprivate func getItemsInternal<T:NSManagedObject>(
        name: String,
        predicate: NSPredicate? = nil
    ) -> [T] {
        var results:[T] = [];
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name);
        fetchRequest.predicate = predicate;
        do {
            let result = try self.managedContext.fetch(fetchRequest);
            if let result = result as? [T] {
                results.append(contentsOf: result);
            }
        } catch {
            print(error);
        }
        return results;
    }
}

/// Delete functional
public extension CoreDataManager {
    
    /// Method which provide the deleting of the object
    /// - Parameter model: instance of the model
    /// - Returns: remove execution description
    @discardableResult
    static func delete<T: NSManagedObject>(
        model: T?
    ) -> Bool {
        return shared.deleteInternal(model: model);
    }
    
    /// Method which provide the deleting of the object
    /// - Parameter model: instance of the model
    /// - Returns: remove execution description
    @discardableResult
    static func delete<T: NSManagedObject>(
        models: [T]?
    ) -> Bool {
        return shared.deleteInternal(models: models);
    }
    
    /// Method which provide the deleting of the object
    /// - Parameter model: instance of the model
    /// - Returns: remove execution description
    @discardableResult
    fileprivate func deleteInternal<T: NSManagedObject>(
        model: T?
    ) -> Bool {
        guard let model = model else {
            return false;
        }
        return self.deleteInternal(models: [model]);
    }
    
    /// Method which provide the deleting of the object
    /// - Parameter model: instance of the model
    /// - Returns: remove execution description
    @discardableResult
    fileprivate func deleteInternal<T: NSManagedObject>(
        models: [T]?
    ) -> Bool {
        guard let models = models else  {
            return false;
        }
        let context = self.managedContext;
        for model in models {
            context.delete(model);
        }
        self.saveInternal();
        return true;
    }
    
}
