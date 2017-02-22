//
//  GraphViewController.swift
//  StrydDataVisualization
//
//  Created by Ryuji Mano on 2/21/17.
//  Copyright © 2017 Ryuji Mano. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    var stryd: Stryd!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        powerButton.layer.cornerRadius = powerButton.frame.width / 2
        heartButton.layer.cornerRadius = heartButton.frame.width / 2
        
        powerButton.imageView?.tintColor = .yellow
        heartButton.imageView?.tintColor = .red
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.stryd.com/b/interview/data")!
        stryd = Stryd(forURL: url, callBack: {
            self.graphView.stryd = self.stryd
            self.graphView.setNeedsDisplay()
            
            
            self.tapGestureRecognizer.addTarget(self, action: #selector(self.onGraphTap))
            self.graphView.addGestureRecognizer(self.tapGestureRecognizer)
        })
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return graphView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func powerButtonTapped(_ sender: Any) {
        if graphView.isPower {
            graphView.isPower = false
            graphView.setNeedsDisplay()
        }
        else {
            graphView.isPower = true
            graphView.setNeedsDisplay()
        }
    }
    
    @IBAction func heartButtonTapped(_ sender: Any) {
        if graphView.isHeart {
            graphView.isHeart = false
            graphView.setNeedsDisplay()
        }
        else {
            graphView.isHeart = true
            graphView.setNeedsDisplay()
        }
    }

    func onGraphTap() {
        performSegue(withIdentifier: "graphSegue", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ZoomViewController
        destination.graphView = self.graphView
        destination.stryd = self.stryd
        destination.isPower = graphView.isPower
        destination.isHeart = graphView.isHeart
    }
 

}
