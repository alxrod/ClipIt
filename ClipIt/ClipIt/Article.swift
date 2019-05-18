//
//  Article.swift
//  ClipIt
//
//  Created by Alex Rodriguez on 5/17/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit

class Article: NSObject {
    var sender: String
    var url: URL
    var title: String
    
    init(sender: String, url: URL, title: String) {
        self.sender = sender
        self.url = url
        self.title = title
    }

}
