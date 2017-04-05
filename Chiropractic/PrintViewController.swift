//
//  PrintViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 4/3/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

struct PrintViewController {
    
    fileprivate let pageHeight = 792
    fileprivate let pageWidth = 612
    fileprivate let contentWidth = 468
    fileprivate let subViewWidth = 93
    fileprivate let subViewHeight = 24
    fileprivate let marginWidth = 72
    
    fileprivate var pageView: UIView
    fileprivate let nameLabel = UILabel()
    fileprivate let kidsLabel = UILabel()
    fileprivate let ageLabel = UILabel()
    fileprivate let paymentLabel = UILabel()
    fileprivate let signatureLabel = UILabel()
    fileprivate let signatureImageView = UIImageView()
    
    init() {
        pageView = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
    }
    
    func printView(forPracticeMembers practiceMembers: [PracticeMember]) -> NSData? {
        
        var practiceMemberIndex = 0
        for practiceMember in practiceMembers {
            
        }
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pageView.frame, nil)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIGraphicsBeginPDFPage()
        pageView.layer.render(in: context)
        UIGraphicsEndPDFContext()
        return pdfData
    }
    
    fileprivate func addViewsToViewForPracticeMember(atIndex index: Int) {
        
    }
    
    fileprivate func setUpColumHeaders() {
        nameLabel.frame = CGRect(x: marginWidth, y: marginWidth - subViewHeight, width: subViewWidth, height: subViewHeight)
        nameLabel.text = .nameDisplayKey
        nameLabel.layer.borderWidth = 1
        
        kidsLabel.frame = CGRect(x: marginWidth + contentWidth + 1, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        kidsLabel.text = .kidsDisplayKey
        kidsLabel.layer.borderWidth = 1
        
        ageLabel.frame = CGRect(x: marginWidth + (contentWidth * 2) + 2, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        ageLabel.text = .ageDisplayKey
        ageLabel.layer.borderWidth = 1
        
        paymentLabel.frame = CGRect(x: marginWidth + (contentWidth * 3) + 3, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        paymentLabel.text = .paymentTypeDisplayKey
        paymentLabel.layer.borderWidth = 1
        
        signatureLabel.frame = CGRect(x: marginWidth + (contentWidth * 4) + 4, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        signatureLabel.text = .signatureDisplayKey
        signatureLabel.layer.borderWidth = 1
        
        
    }
}
