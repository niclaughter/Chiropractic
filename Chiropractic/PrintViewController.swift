//
//  PrintViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 4/3/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

struct PrintViewController {
    
    /*
     let name: String
     let kids: String
     let adultOrChild: AdultOrChild
     let paymentType: PaymentType
     var identifier: String?
     let signedInDate: Date
     */
    
    static func printView(forPracticeMembers practiceMembers: [PracticeMember]) -> NSData? {
        let view = UIView()
        for practiceMember in practiceMembers {
            
        }
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIGraphicsBeginPDFPage()
        view.layer.render(in: context)
        UIGraphicsEndPDFContext()
        return pdfData
    }
}
