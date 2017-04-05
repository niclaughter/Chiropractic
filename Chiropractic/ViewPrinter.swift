//
//  ViewPrinter.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 4/3/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

struct ViewPrinter {
    
    fileprivate let pageHeight = 792
    fileprivate let pageWidth = 612
    fileprivate let contentWidth = 468
    fileprivate let contentHeight = 648
    fileprivate let maxPracticeMembersPerPage = 27
    fileprivate let subViewWidth = 93
    fileprivate let subViewHeight = 24
    fileprivate let marginWidth = 72
    
    func printData(forPracticeMembers practiceMembers: [PracticeMember], onPresentingViewController presentingViewController: UIViewController) {
        guard let dataToPrint = getDataToPrint(forPracticeMembers: practiceMembers) else { return }
        let activityViewController = UIActivityViewController(activityItems: [dataToPrint], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.addToReadingList, .airDrop, .assignToContact, .copyToPasteboard, .message, .openInIBooks, .postToFacebook, .postToFlickr, .postToTencentWeibo, .postToTwitter, .postToVimeo, .postToWeibo]
        presentingViewController.present(activityViewController, animated: true, completion: nil)
    }
    
    private func getDataToPrint(forPracticeMembers practiceMembers: [PracticeMember]) -> NSData? {
        let pageCount = Int(ceil(Double(practiceMembers.count) / Double(maxPracticeMembersPerPage)))
        if pageCount != 0 {
            let views = (1...pageCount).map { (pageNumber: Int) -> UIView in
                let pdfPageView = setUpColumHeaders()
                let pageRange = ((pageNumber - 1) * maxPracticeMembersPerPage)..<(min(pageNumber * maxPracticeMembersPerPage, practiceMembers.count))
                let practiceMembersForPage = Array(practiceMembers[pageRange])
                addViews(toPrinterView: pdfPageView, forPracticeMembers: practiceMembersForPage)
                pdfPageView.removeFromSuperview()
                return pdfPageView
            }
            return toPDF(views: views)
        } else {
            return toPDF(views: [setUpColumHeaders()])
        }
    }
    
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
    
    private func addViews(toPrinterView printerView: UIView, forPracticeMembers practiceMembers: [PracticeMember]) {
        
        for practiceMember in practiceMembers {
            guard let index = practiceMembers.index(of: practiceMember),
                let identifier = practiceMember.identifier,
                let signatureImage = ImageController.shared.imagesDict[identifier] else { return }
            
            let nameLabel = getLabel()
            let kidsLabel = getLabel()
            let ageLabel = getLabel()
            let paymentLabel = getLabel()
            let signatureImageView = UIImageView()
            
            nameLabel.frame = CGRect(x: self.marginWidth,
                                     y: self.marginWidth + self.subViewHeight * index,
                                     width: self.subViewWidth,
                                     height: self.subViewHeight)
            nameLabel.text = practiceMember.name
            printerView.addSubview(nameLabel)
            
            kidsLabel.frame = CGRect(x: self.marginWidth + self.subViewWidth,
                                     y: self.marginWidth + self.subViewHeight * index,
                                     width: self.subViewWidth,
                                     height: self.subViewHeight)
            kidsLabel.text = practiceMember.kids
            printerView.addSubview(kidsLabel)
            
            ageLabel.frame = CGRect(x: self.marginWidth + (self.subViewWidth * 2),
                                    y: self.marginWidth + self.subViewHeight * index,
                                    width: self.subViewWidth,
                                    height: self.subViewHeight)
            ageLabel.text = practiceMember.adultOrChild.rawValue
            printerView.addSubview(ageLabel)
            
            paymentLabel.frame = CGRect(x: self.marginWidth + (self.subViewWidth * 3),
                                        y: self.marginWidth + self.subViewHeight * index,
                                        width: self.subViewWidth,
                                        height: self.subViewHeight)
            paymentLabel.text = practiceMember.paymentType.rawValue
            printerView.addSubview(paymentLabel)
            
            signatureImageView.frame = CGRect(x: self.marginWidth + (self.subViewWidth * 4),
                                              y: self.marginWidth + self.subViewHeight * index,
                                              width: self.subViewWidth,
                                              height: self.subViewHeight)
            signatureImageView.contentMode = .scaleAspectFit
            signatureImageView.image = signatureImage
            signatureImageView.layer.borderWidth = 1
            printerView.addSubview(signatureImageView)
            
        }
    }
    
    private func setUpColumHeaders() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
        let nameLabel = getLabel()
        let kidsLabel = getLabel()
        let ageLabel = getLabel()
        let paymentLabel = getLabel()
        let signatureLabel = getLabel()
        
        nameLabel.frame = CGRect(x: marginWidth,
                                 y: marginWidth - subViewHeight,
                                 width: subViewWidth,
                                 height: subViewHeight)
        nameLabel.text = .nameDisplayKey
        view.addSubview(nameLabel)
        
        kidsLabel.frame = CGRect(x: marginWidth + subViewWidth,
                                 y: marginWidth - subViewHeight,
                                 width: subViewWidth,
                                 height: subViewHeight)
        kidsLabel.text = .kidsDisplayKey
        view.addSubview(kidsLabel)
        
        ageLabel.frame = CGRect(x: marginWidth + subViewWidth * 2,
                                y: marginWidth - subViewHeight,
                                width: subViewWidth,
                                height: subViewHeight)
        ageLabel.text = .ageDisplayKey
        view.addSubview(ageLabel)
        
        paymentLabel.frame = CGRect(x: marginWidth + subViewWidth * 3,
                                    y: marginWidth - subViewHeight,
                                    width: subViewWidth,
                                    height: subViewHeight)
        paymentLabel.text = .paymentTypeDisplayKey
        view.addSubview(paymentLabel)
        
        signatureLabel.frame = CGRect(x: marginWidth + subViewWidth * 4,
                                      y: marginWidth - subViewHeight,
                                      width: subViewWidth,
                                      height: subViewHeight)
        signatureLabel.text = .signatureDisplayKey
        view.addSubview(signatureLabel)
        
        return view
    }
    
    private func getLabel() -> UILabel {
        let label = UILabel()
        label.layer.borderWidth = 1
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }
}
