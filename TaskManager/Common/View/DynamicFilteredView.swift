//
//  DynamicFilteredView.swift
//  TaskManagementCoreData (iOS)
//
//  Created by Balaji on 12/01/22.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View,T>: View where T: NSManagedObject {
    // MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    // MARK: Building Custom ForEach which will give Coredata object to build View
    init(sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil, @ViewBuilder content: @escaping (T)->Content){

        // Intializing Request With NSPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        
        Group{
            if request.isEmpty{
                Text("No tasks found!!!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y: 100)
            }
            else{
                
                ForEach(request,id: \.objectID) { object in
                    content(object)
                }
            }
        }
    }
}
