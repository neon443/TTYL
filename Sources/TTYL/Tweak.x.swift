import Orion
import TTYLC
import UIKit
import AudioToolbox

class TTYHook: ClassHook<UILabel> {
	func setText(_ text: String) {
		orig.setText("sybau 🥀")
//		let x = AudioEngine()
	}
}
