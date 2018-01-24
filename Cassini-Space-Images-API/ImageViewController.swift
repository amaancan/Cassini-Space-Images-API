//
//  ImageViewController.swift
//  Cassini-Space-Images-API
//
//  Created by Amaan on 2018-01-23.
//  Copyright © 2018 amaancan. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // green arrow that points to my model
    var imageURL: URL? {
        didSet {
            imageView.image = nil // clear current image
            if view.window != nil { // if I'm already screen as opposed to image being set while I'm on another screen
                fetchImage() // get new image when url changes
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = URL(string: "https://apod.nasa.gov/apod/image/1801/NGC1398_ESO_960.jpg")
            print(imageURL!)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    private func fetchImage () {
        
        if let imageURL = imageURL {
            if let imageData = try? Data(contentsOf: imageURL) {
               imageView.image = UIImage(data: imageData)
                
            }
        }
    }
}
