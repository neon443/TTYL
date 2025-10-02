import Foundation
import Orion
import TTYLC
import UIKit
import AudioToolbox

class DialerHook: ClassHook<UIViewController> {
	static var targetName: String { "PHInCallKeypadViewController" }
	
	var timer: Timer?
	
	func viewDidLoad() {
		orig.viewDidLoad()
		
		timer = Timer(timeInterval: 0.1, repeats: true) { timer in
			NSLog("TTYLnslog")
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now()) {
			RunLoop.main.add(self.timer!, forMode: .default)
			
			let tbox = UITextField()
			tbox.autocapitalizationType = .none
			tbox.autocorrectionType = .no
			tbox.borderStyle = .bezel
			tbox.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
			self.target.view.addSubview(tbox)
			self.target.view.bringSubviewToFront(tbox)
		}
	}
}
