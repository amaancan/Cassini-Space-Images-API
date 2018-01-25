//
//  ImageViewController.swift
//  Cassini-Space-Images-API
//
//  Created by Amaan on 2018-01-23.
//  Copyright © 2018 amaancan. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    // TODO: Issue - ScrollView is not letting me scroll the image out of the un-safe area at the top for images fetched over the internet. It works for images set manually...
    
    //TODO: image is aligned to top left of imageview or imageview is aligned to top left of scrollview (contentArea) ... need to make it centre.
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/10
            scrollView.maximumZoomScale = 3.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //image = #imageLiteral(resourceName: "sunlitFieldFrance")
        if imageURL == nil {
            imageURL = URL(string: "https://apod.nasa.gov/apod/image/1801/NGC1398_ESO_960.jpg")
            print(imageURL!)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if image == nil {
            fetchImage() //MARK: Question: How are all scenarios of when to fetch image covered?
        }
    }
    
    
    var imageView = UIImageView()
    
    //Good use of computed var:
    private var image: UIImage? {
        // Everytime I want to get or set my image, I'll get/set it from/to the imageView
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            // Everytime I set my image, I resize my imageView and scrollView accroding to new set image (since ea. image is of diff. size)
            imageView.sizeToFit() // makes itself intrinsic size, just enough to fit it's image in
            scrollView.contentSize = imageView.frame.size // *** Required for scrolling (panning). Otherwise, the contentSize will be a 0x0 rect so scrollView has no area to move around in!
        }
    }
    
    // 'green arrow' that points to my model
    // MARK: Question - How does imageURL is set vs. image is set play out?
    var imageURL: URL? {
        didSet {
            image = nil // clear current image
            if view.window != nil { // if I'm already on this screen as opposed to image being set while I'm on another screen
                fetchImage() // get new image when url changes
            }
        }
    }
    
    private func fetchImage () {
        if let imageURL = imageURL {
            if let imageData = try? Data(contentsOf: imageURL) {
                image = UIImage(data: imageData)
            }
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView // This is the subview in the scrollView's contentArea that we want to be tranformed when we pinch
    }
}
