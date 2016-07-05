//
//  RootViewController.swift
//  NativeWallet
//
//  Created by Marek Kotewicz on 04/07/16.
//  Copyright © 2016 Marek Kotewicz. All rights reserved.
//

import UIKit
import SideMenu

class RootViewController: UIViewController {
	@IBOutlet weak var container: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

		SideMenuManager.menuRightNavigationController = storyboard!.instantiateViewControllerWithIdentifier("SideMenuNavigationController") as? UISideMenuNavigationController
		
		SideMenuManager.menuLeftNavigationController = nil
		//		SideMenuManager.menuAnimationBackgroundColor = UIColor(red: 24.0/255, green: 23.0/255, blue: 29.0/255, alpha: 1)
		SideMenuManager.menuAnimationBackgroundColor = UIColor(red: 36.0/255, green: 35.0/255, blue: 41.0/255, alpha: 1)
		SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
		SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
		SideMenuManager.menuPresentMode = .ViewSlideInOut
		SideMenuManager.menuAnimationTransformScaleFactor = 0.8
		SideMenuManager.menuAnimationFadeStrength = 0.8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
