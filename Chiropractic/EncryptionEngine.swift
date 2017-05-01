//
//  EncryptionEngine.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 5/1/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation
import RNCryptor

struct EncryptionEngine {
    
    func encryptToString(data: Data) -> String {
        return RNCryptor.encrypt(data: data, withPassword: .encryptionKey).base64EncodedString()
    }
    
    func encryptToData(data: Data) -> Data {
        return RNCryptor.encrypt(data: data, withPassword: .encryptionKey)
    }
    
    func decryptFromString(string: String) -> Data? {
        guard let data = Data(base64Encoded: string) else { fatalError("Could not get data from base64EncodedString in: \(#function)") }
        return try? RNCryptor.decrypt(data: data, withPassword: .encryptionKey)
    }
    
    func decrypt(fromData data: Data) -> Data? {
        return try? RNCryptor.decrypt(data: data, withPassword: .encryptionKey)
    }
}
