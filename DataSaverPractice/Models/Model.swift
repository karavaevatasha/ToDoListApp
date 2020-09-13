//
//  Model.swift
//  DataSaverPractice
//
//  Created by Nataliia on 07.09.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//
import Foundation
import UserNotifications
import UIKit

var todoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "TodoDataKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "TodoDataKey") as?  [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    todoItems.append(["Name": nameItem, "isCompleted": false])
    setBadge()
}

func removeItem(at index: Int) {
    todoItems.remove(at: index)
    setBadge()
}

func moveItem(fromIndex: Int, toIndex: Int){
    let from = todoItems[fromIndex]
    todoItems.remove(at: fromIndex)
    todoItems.insert(from, at: toIndex)
}

func changeState( at item: Int) -> Bool {
    todoItems[item]["isCompleted"] = !(todoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return todoItems[item]["isCompleted"] as! Bool
}

func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled {
            print("Согласие получено")
        } else {
            print("Пришел отказ")
        }
    }
}

func setBadge() {
    var totalBadgeNumber = 0
    let array = todoItems
    for item in array{
        if (item["isCompleted"] as? Bool) == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}


