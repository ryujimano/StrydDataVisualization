//
//  ZoomViewController.swift
//  StrydDataVisualization
//
//  Created by Ryuji Mano on 2/21/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var graphView: GraphView!
    var stryd: Stryd!
    
    var isHeart: Bool!
    var isPower: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
        graphView.stryd = stryd
        graphView.isPower = isPower
        graphView.isHeart = isHeart
        graphView.setNeedsDisplay()
        
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.zoomScale = scrollView.minimumZoomScale
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return graphView
    }

    
    @IBAction func onDoneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
