//
//  ShareViewController.swift
//  ClipItShare
//
//  Created by Alex Rodriguez on 5/19/19.
//  Copyright © 2019 Alex Rodriguez. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
//    means has to be defined
    var selectedURL: URL!
    var receiverEmail: String!
    
    
    override func viewDidLoad() {
        placeholder = "Who do you want to share the article with?"
    }
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        if let currentSender = contentText {
            if currentSender.contains("@") {
                
            }
        }
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
