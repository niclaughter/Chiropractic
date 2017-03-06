//
//  ImageController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 3/5/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class ImageController {
    
    static func saveSignatureImageToDatabase(_ image: UIImage, completion: @escaping (URL?, String) -> Void = { _ in }) {
        let identifier = FirebaseController.databaseRef.child(Constants.practiceMembersEndpoint).childByAutoId().key
        defer { completion(nil, identifier) }
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { return }
        let signatureRef = FirebaseController.storageRef.child(Constants.imagesEndpoint).child(Constants.signaturesEndpoint).child(identifier)
        signatureRef.put(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                NSLog("Error saving signature image:\n\(error)")
            }
            guard let metadata = metadata else {
                NSLog("Error retrieving metadata from saved image")
                return
            }
            completion(metadata.downloadURL(), identifier)
        }
    }
}
