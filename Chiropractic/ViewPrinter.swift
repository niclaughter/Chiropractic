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
    fileprivate let maxPracticeMembersPerPage = 30
    fileprivate let defaultSubviewWidth = 93
    fileprivate let timestampLabelWidth = 72
    fileprivate let kidsLabelWidth = 133
    fileprivate let ageLabelWidth = 53
    fileprivate let labelOffset = 40
    fileprivate let subviewHeight = 24
    fileprivate let marginWidth = 36
    
    fileprivate let dateHelper = DateHelper()
    
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
                let identifier = practiceMember.identifier else { return }
            
            let nameLabel = getLabel()
            let timestampLabel = getLabel()
            let kidsLabel = getLabel()
            let ageLabel = getLabel()
            let paymentLabel = getLabel()
            let signatureImageView = UIImageView()
            
            nameLabel.frame = CGRect(x: marginWidth + timestampLabelWidth,
                                     y: marginWidth + subviewHeight * index,
                                     width: defaultSubviewWidth,
                                     height: subviewHeight)
            nameLabel.text = practiceMember.name
            printerView.addSubview(nameLabel)
            
            timestampLabel.frame = CGRect(x: marginWidth,
                                          y: marginWidth + subviewHeight * index,
                                          width: timestampLabelWidth,
                                          height: subviewHeight)
            timestampLabel.text = dateHelper.dateFormatter.string(from: practiceMember.signedInDate)
            printerView.addSubview(timestampLabel)
            
            kidsLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth,
                                     y: marginWidth + subviewHeight * index,
                                     width: kidsLabelWidth,
                                     height: subviewHeight)
            kidsLabel.numberOfLines = 0
            kidsLabel.text = !practiceMember.kids.isEmpty ? practiceMember.kids : "No kids"
            printerView.addSubview(kidsLabel)
            
            ageLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth * 2 + labelOffset,
                                    y: marginWidth + subviewHeight * index,
                                    width: ageLabelWidth,
                                    height: subviewHeight)
            ageLabel.text = practiceMember.adultOrChild.rawValue
            printerView.addSubview(ageLabel)
            
            paymentLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth * 3,
                                        y: marginWidth + subviewHeight * index,
                                        width: defaultSubviewWidth,
                                        height: subviewHeight)
            paymentLabel.text = practiceMember.paymentType.rawValue
            printerView.addSubview(paymentLabel)
            
            signatureImageView.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth * 4,
                                              y: marginWidth + subviewHeight * index,
                                              width: defaultSubviewWidth,
                                              height: subviewHeight)
            signatureImageView.contentMode = .scaleAspectFit
            signatureImageView.image = ImageController.shared.imagesDict[identifier]
            signatureImageView.layer.borderWidth = 1
            printerView.addSubview(signatureImageView)
            
        }
    }
    
    private func setUpColumHeaders() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
        let timestampLabel = getLabel()
        let nameLabel = getLabel()
        let kidsLabel = getLabel()
        let ageLabel = getLabel()
        let paymentLabel = getLabel()
        let signatureLabel = getLabel()
        
        timestampLabel.frame = CGRect(x: marginWidth,
                                      y: marginWidth - subviewHeight,
                                      width: defaultSubviewWidth, height: subviewHeight)
        timestampLabel.text = .timestampDisplayKey
        view.addSubview(timestampLabel)
        
        nameLabel.frame = CGRect(x: marginWidth + timestampLabelWidth,
                                 y: marginWidth - subviewHeight,
                                 width: defaultSubviewWidth,
                                 height: subviewHeight)
        nameLabel.text = .nameDisplayKey
        view.addSubview(nameLabel)
        
        kidsLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth,
                                 y: marginWidth - subviewHeight,
                                 width: kidsLabelWidth,
                                 height: subviewHeight)
        kidsLabel.text = .kidsDisplayKey
        view.addSubview(kidsLabel)
        
        ageLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth * 2 + labelOffset,
                                y: marginWidth - subviewHeight,
                                width: ageLabelWidth,
                                height: subviewHeight)
        ageLabel.text = .ageDisplayKey
        view.addSubview(ageLabel)
        
        paymentLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth * 3,
                                    y: marginWidth - subviewHeight,
                                    width: defaultSubviewWidth,
                                    height: subviewHeight)
        paymentLabel.text = .paymentTypeDisplayKey
        view.addSubview(paymentLabel)
        
        signatureLabel.frame = CGRect(x: marginWidth + timestampLabelWidth + defaultSubviewWidth * 4,
                                      y: marginWidth - subviewHeight,
                                      width: defaultSubviewWidth,
                                      height: subviewHeight)
        signatureLabel.text = .signatureDisplayKey
        view.addSubview(signatureLabel)
        
        return view
    }
    
    private func getLabel() -> PrinterLabel {
        let label = PrinterLabel()
        label.layer.borderWidth = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }
}
