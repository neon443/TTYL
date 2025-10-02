import Foundation
import Orion
import TTYLC
import UIKit
import AudioToolbox

class xhook: ClassHook<UIViewController> {
	static var targetName: String { "PHInCallKeypadViewController" }
	
	func viewDidLoad() {
		orig.viewDidLoad()
		
		DispatchQueue.main.asyncAfter(deadline: .now()+1) {
			let l = UILabel()
			l.textColor = .black
			l.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
			l.text = ""
			self.target.view.addSubview(l)
			self.target.view.bringSubviewToFront(l)
		}
		
		AudioServicesPlayAlertSoundWithCompletion(1103) {
			AudioServicesPlayAlertSoundWithCompletion(1103) {
				AudioServicesPlayAlertSound(1103)
			}
		}
	}
}
