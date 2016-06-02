//
//  StudentDetailsViewController.swift
//  Career Fair
//
//  Created by Adam Birdsall on 3/23/16.
//  Copyright © 2016 Adam Birdsall. All rights reserved.
//

import UIKit
import Firebase

class StudentDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var graduateText: UILabel!
    @IBOutlet weak var gradeText: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var scrollView: UIScrollView!

    var info:Info = Info()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameText.text = "\(info.firstName) \(info.lastName)"
        self.emailText.text = info.email
        self.graduateText.text = info.graduate
        self.gradeText.text = info.grade
        
        // Decoding image that is in Firebase
        let decodedData = NSData(base64EncodedString: info.resume, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data: decodedData!)
                
        self.imageView.image = decodedImage
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 1.0
    }

    @IBAction func fullScreenResume(sender: AnyObject) {
        
        
        setUpScrollView()
        
        scrollView.delegate = self
        
        setZoomScaleFor(scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        recenterImage()
        
        self.navigationController?.navigationBar.alpha = 0.0

    }
    
    // MARK: - Set up scroll view
    
    private func setUpScrollView()
    {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    private func setZoomScaleFor(scrollViewSize: CGSize)
    {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minimumScale = min(widthScale, heightScale)
        
        // set up zooming properties for the scroll view
        scrollView.minimumZoomScale = minimumScale
        scrollView.maximumZoomScale = 3.0
    }
    
    private func recenterImage()
    {
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        let horizontalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2.0 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
}

extension StudentDetailsViewController : UIScrollViewDelegate
{
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        self.recenterImage()
    }
}
