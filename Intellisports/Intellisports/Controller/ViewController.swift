//
//  ViewController.swift
//  Intellisports
//
//  Created by Sri Vidya Soundarya Vivekanandan on 2021-01-05.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIScrollViewDelegate {

    //MARK: - Varaiable Declaration
    var dictResponse = NSDictionary()
    var arrResponse: NSArray = []
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblView: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    var pageNumber: Int = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPIResponse()
    }
    
    //MARK: - API Implementation
    func getAPIResponse() {
        ServiceConnector.serviceConnectorGET() {
            responseObject,error,statusCode in
            if (error == nil) {
                let code: Int = statusCode!
                NSLog("\(code)")
                print(code)
                self.dictResponse = NSDictionary()
                self.dictResponse = responseObject! as NSDictionary
                print("response \(self.dictResponse)")
                self.arrResponse = NSArray()
                self.arrResponse = self.dictResponse.value(forKey: "players_list") as! NSArray
                 print(self.arrResponse.count)
                 print(self.arrResponse)
            }
            self.pageControl.numberOfPages = self.arrResponse.count
            self.initialSetup()
        }
    }
    
    //MARK: - User Defined Methods
    func initialSetup() {
        for index in 0..<arrResponse.count {
            var lblframe = lblView.frame
            lblframe.origin.x = lblView.frame.size.width * CGFloat(index)
            lblframe.size = lblView.frame.size
            lblView = UILabel(frame: lblframe)
            lblView.text = (self.arrResponse[index] as AnyObject).object(forKey: "name") as? String
            lblView.textAlignment = .center
            lblView.numberOfLines = 2
            
            var frame = imageView.frame
            frame.origin.x = imageView.frame.size.width * CGFloat(index)
            frame.size = imageView.frame.size
            imageView = UIImageView(frame: frame)
            if let data = try? Data(contentsOf: URL(string: ((self.arrResponse[index] as AnyObject).object(forKey: "profile_image") as! String))!) {
                    imageView.image = UIImage(data: data)
                }
            self.scrollView.addSubview(imageView)
            self.scrollView.addSubview(lblView)
         }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(arrResponse.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    
    //MARK: - IBAction
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0 {
            if pageNumber == 1 {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                pageNumber = 0
                pageControl.currentPage = Int(pageNumber)
            } else if pageNumber == 2 {
                scrollView.setContentOffset(CGPoint(x: imageView.frame.width, y: 0), animated: true)
                pageNumber = 1
                pageControl.currentPage = Int(pageNumber)
            }
        } else if sender.tag == 1 {
            if pageNumber == 0 {
                scrollView.setContentOffset(CGPoint(x: imageView.frame.width, y: 0), animated: true)
                pageNumber = 1
                pageControl.currentPage = Int(pageNumber)
            } else if pageNumber == 1 {
                scrollView.setContentOffset(CGPoint(x: imageView.frame.width + 293, y: 0), animated: true)
                pageNumber = 2
                pageControl.currentPage = Int(pageNumber)
            } else {
                return
            }
            
        }
    }
    
    //MARK: - Delegate Method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(scrollView.contentOffset.x)
    }
}

