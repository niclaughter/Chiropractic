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
    fileprivate let contentHeight = 648
    fileprivate let maxPracticeMembersPerPage = 27
    fileprivate let subViewWidth = 93
    fileprivate let subViewHeight = 24
    fileprivate let marginWidth = 72
    
    fileprivate let nameLabel = UILabel()
    fileprivate let kidsLabel = UILabel()
    fileprivate let ageLabel = UILabel()
    fileprivate let paymentLabel = UILabel()
    fileprivate let signatureLabel = UILabel()
    fileprivate let signatureImageView = UIImageView()
    
    fileprivate let imageController = ImageController()
    
    func printView(forPracticeMembers practiceMembers: [PracticeMember]) -> NSData? {
        let pageCount = Int(ceil(Double(practiceMembers.count) / Double(maxPracticeMembersPerPage)))
        if pageCount != 0 {
            let views = (1...pageCount).map { (pageNumber: Int) -> UIView in
                let pdfPageView = setUpColumHeaders()
                let pageRange = ((pageNumber - 1) * maxPracticeMembersPerPage)..<(min(pageNumber * maxPracticeMembersPerPage, practiceMembers.count))
                let practiceMembersForPage = Array(practiceMembers[pageRange])
            }
            return toPDF(views: views)
        } else {
            return nil
        }
        
//        var practiceMemberIndex = 0
//        for practiceMember in practiceMembers {
//            addViews(toPrinterView: <#T##UIView#>, forPracticeMember: <#T##PracticeMember#>, atIndex: <#T##Int#>)
//            practiceMemberIndex += 1
//        }
    }
    
    
//    func renderAsPDF(demandEntry: ParsedDemandEntry, inView view: UIView) -> NSData? {
//        let entries = demandEntry.demands
//        let pageCount = Int(ceil(Double(entries.count) / Double(demandCountForPage)))
//        if pageCount != 0 {
//            let views = (1...pageCount).map { (pageNumber: Int) -> UIView in
//                let pdfPageView = createTemplatePageViewWithParsedEntry(demandEntry, inView: view)
//                
//                let pageRange = ((pageNumber - 1) * demandCountForPage)..<(min(pageNumber * demandCountForPage, entries.count))
//                let entriesForPage = Array(entries[pageRange])
//                
//                addEntries(entriesForPage, toView: pdfPageView)
//                
//                pdfPageView.removeFromSuperview()
//                
//                return pdfPageView
//            }
//            
//            return toPDF(views)
//        } else {
//            return nil
//        }
//    }
    
    private func toPDF(views: [UIView]) -> NSData? {
        
        if views.isEmpty {
            return nil
        }
    
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), nil)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        for view in views {
            UIGraphicsBeginPDFPage()
            view.layer.render(in: context)
        }
        
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
    /*
     var pdfLoc = NSURL(fileURLWithPath:yourPdfFilePath)
     let printController = UIPrintInteractionController.sharedPrintController()!
     let printInfo = UIPrintInfo(dictionary:nil)!
     
     printInfo.outputType = UIPrintInfoOutputType.General
     printInfo.jobName = "print Job"
     printController.printInfo = printInfo
     printController.printingItem = pdfLoc
     printController.presentFromBarButtonItem(printButton, animated: true, completionHandler: nil)
     */
    
    fileprivate func addViews(toPrinterView printerView: UIView, forPracticeMembers practiceMembers: [PracticeMember], atIndex index: Int) {
        
    }
    
    fileprivate func setUpColumHeaders() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
        
        nameLabel.frame = CGRect(x: marginWidth, y: marginWidth - subViewHeight, width: subViewWidth, height: subViewHeight)
        nameLabel.text = .nameDisplayKey
        nameLabel.layer.borderWidth = 1
        view.addSubview(nameLabel)
        
        kidsLabel.frame = CGRect(x: marginWidth + contentWidth + 1, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        kidsLabel.text = .kidsDisplayKey
        kidsLabel.layer.borderWidth = 1
        view.addSubview(kidsLabel)
        
        ageLabel.frame = CGRect(x: marginWidth + (contentWidth * 2) + 2, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        ageLabel.text = .ageDisplayKey
        ageLabel.layer.borderWidth = 1
        view.addSubview(ageLabel)
        
        paymentLabel.frame = CGRect(x: marginWidth + (contentWidth * 3) + 3, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        paymentLabel.text = .paymentTypeDisplayKey
        paymentLabel.layer.borderWidth = 1
        view.addSubview(paymentLabel)
        
        signatureLabel.frame = CGRect(x: marginWidth + (contentWidth * 4) + 4, y: marginWidth - 24, width: subViewWidth, height: subViewHeight)
        signatureLabel.text = .signatureDisplayKey
        signatureLabel.layer.borderWidth = 1
        view.addSubview(signatureLabel)
        
        return view
    }
}
