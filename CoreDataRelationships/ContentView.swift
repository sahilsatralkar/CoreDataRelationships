//
//  ContentView.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 22/03/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var dataController : DataController
    
    let schools : FetchRequest<School>
    
    init(){
        schools = FetchRequest<School>(entity: School.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \School.date, ascending: false)])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    List {
                        ForEach(schools.wrappedValue) { school in
                            NavigationLink (destination: DetailView(school: school )){
                                VStack(alignment: .leading) {
                                    Text(school.name ?? "").font(.headline)
                                    Spacer()
                                    Text("Address: \(school.address ?? "")").font(.subheadline)
                                    
                                }.padding()
                                
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
            }
            .navigationTitle("School")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Add Sample Data") {
                        dataController.deleteAll()
                        dataController.createSampleData()
                    }
                }
            }
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
