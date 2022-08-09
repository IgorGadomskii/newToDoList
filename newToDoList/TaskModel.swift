

import Foundation
import UIKit

struct newTask{
    var name: String!
    var date: Date!
    var tagColor: UIColor!
    
    private init(name: String, date: Date, tagColor: UIColor ) {
        self.name = name
        self.date = date
        self.tagColor = tagColor
    }
    
//    private init() {}
}

extension newTask {
    
    static func shared() -> newTask {
        return newTask(name: "", date: .now, tagColor: .gray)
    }
    
    func getTaskList() -> [newTask] {
        return []
    }
}
