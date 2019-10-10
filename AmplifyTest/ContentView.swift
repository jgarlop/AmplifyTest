//
//  ContentView.swift
//  AmplifyTest
//
//  Created by Javier García on 10/10/2019.
//  Copyright © 2019 Javier García. All rights reserved.
//

import SwiftUI
import AWSAppSync

struct ContentView: View {
    let dataManager:DataManager = DataManager()
    var body: some View {
        VStack{
            Text("Prueba de Amplify").font(.largeTitle).padding()
            Text("Usando AWS con GraphQL").foregroundColor(.yellow)

            ToDoFields(dataManager: dataManager)
            Button(action: {self.dataManager.runQuery()}){
                Text("Realizar query").padding().frame(width:200, height: 50).background(Color.yellow)
            }
            }.padding().background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
    }
}

struct ToDoFields : View {
    
    @State var nombreTarea: String = ""
    @State var description: String = ""
    let dataManager: DataManager
    var body : some View {
        VStack{
            Text("Introducir una tarea nueva")
            TextField("Nombre de la tarea", text: $nombreTarea).padding().background(Color.blue).cornerRadius(5).padding()
            TextField("Descripcion de la tarea", text: $description).padding().background(Color.blue).cornerRadius(5).padding()
            Button(action: {self.dataManager.runMutation(taskName: self.nombreTarea, description: self.description)}){
                Text("Realizar mutation").padding().frame(width:200, height: 50).background(Color.yellow)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
