//
//  DataManager.swift
//  AmplifyTest
//
//  Created by Javier García on 10/10/2019.
//  Copyright © 2019 Javier García. All rights reserved.
//

import Foundation
import AWSAppSync

class DataManager {
    
    var appSyncClient: AWSAppSyncClient?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init(){
        appSyncClient = appDelegate.appSyncClient
    }
    
    func runMutation(taskName: String, description: String){
        let mutationInput = CreateTodoInput(name: taskName, description: description)
        appSyncClient?.perform(mutation: CreateTodoMutation(input: mutationInput)) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
            if let resultError = result?.errors {
                print("Errores al hacer cambios en el servidor:  \(resultError)")
            }
            print ("Mutation completada")
        }
    }
    
    func runQuery(){
           appSyncClient?.fetch(query: ListTodosQuery(), cachePolicy: .returnCacheDataAndFetch) {(result, error) in
               if error != nil {
                   print(error?.localizedDescription ?? "")
                   return
               }
               print("Query completada")
            var index = 0
            result?.data?.listTodos?.items!.forEach {
                print(String(index) + " :" + ($0?.name)! + " " + ($0?.description)!)
                index += 1
            }
           }
       }
}




