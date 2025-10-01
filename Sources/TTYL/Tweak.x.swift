import Foundation
import Orion
import TTYLC
import UIKit
import CallKit
import AudioToolbox

class TTYHook: ClassHook<CXCallObserver> {
	func setText(_ text: String) {
		orig.setText("sybau 🥀")
	}
}
